local already_registered = false
local M = {}

---Map cargo diagnostics levels to vim diagnostic levels.
M.severities = {
    error = vim.diagnostic.severity.ERROR,
    warning = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    help = vim.diagnostic.severity.HINT,
    note = vim.diagnostic.severity.HINT,
}

---Find bufnr from path and cargo manifest path.
---@param path string 'path of file'
---@param manifest_path string 'path of Cargo.toml'
---@return number? 'bufnr of path'
local function rust_file_bufnr(path, manifest_path)
    local fullpath = vim.fn.substitute(manifest_path, "Cargo.toml", path, "")
    for _, i in ipairs(vim.api.nvim_list_bufs()) do
        local buf_path = vim.fn.expand("#" .. i .. ":p")
        if buf_path == fullpath then
            print(buf_path .. "=" .. fullpath)
            return i
        end
    end
end

---Recusively convert message into diagnostic and insert it to diagnostics list.
---@param diagnostics table 'destination of found diagnostics'
---@param message table 'part of cargo check's output may represent diagnostic message'
---@param manifest_path string 'path of rust manifest file: `Cargo.toml`'
local function add_message(diagnostics, message, manifest_path)
    -- do recursive about message.children
    for _, child in ipairs(message.children or {}) do
        add_message(diagnostics, child or {}, manifest_path)
    end

    if -- is it has span?
        not message.spans
        or not message.spans[1]
        or not message.spans[1].line_start
        or not message.spans[1].column_start
    then
        return
    end
    local spans = message.spans[1]

    local current_bufnr = vim.api.nvim_get_current_buf()
    local bufnr = rust_file_bufnr(spans.file_name, manifest_path)
    if not bufnr then
        return
    end
    if bufnr ~= current_bufnr then
        print("↑" .. bufnr .. "!=" .. current_bufnr .. ": " .. message.message)
        return
    end
    print("↑" .. bufnr .. "==" .. current_bufnr .. ": " .. message.message)

    local diagnostic = {
        -- NOTE: seems like this bufnr have no effect?
        bufnr = bufnr, -- this is optional. But, without this, does not make any sense for cargo output.
        lnum = spans.line_start - 1,
        col = spans.column_start - 1,
        message = message.message,
    }
    -- optionals
    if message.level then
        diagnostic.severity = assert(M.severities[message.level], "missing mapping for severity " .. message.level)
    end
    if message.code and message.code ~= vim.NIL and message.code.code then
        diagnostic.code = message.code.code
    end
    if spans.line_end then
        diagnostic.end_lnum = spans.line_end - 1
    end
    if spans.column_end then
        diagnostic.end_col = spans.column_end - 1
    end
    table.insert(diagnostics, diagnostic)
end

---Parse `cargo check`/`clippy`'s output to generate vim diagnostics.
---@param output string 'lines of json, which is cargo check\'s json style output'
---@return table 'list of diagnostics'
function M.parser(output)
    print("start")
    local diagnostics = {}
    for json in output:gmatch("[^\r\n]+") do --split lines
        local is_success, decoded = pcall(vim.json.decode, json)
        if is_success and type(decoded) == "table" and decoded.reason == "compiler-message" then
            add_message(diagnostics, decoded.message, decoded.manifest_path)
        end
    end
    return diagnostics
end

---Get rust-analyzer's root dir
---TODO: I'm not sure which root dir is returned if multiple rust-analyzer running.
---@return string?
local function get_rust_analyzer_root_dir()
    local clients = vim.lsp.get_active_clients()
    local root_dir
    for _, client in pairs(clients) do
        if client.name == "rust_analyzer" then
            if client.workspaceFolders then
                root_dir = client.workspaceFolders[1].name
            end
        end
    end
    return root_dir
end

---@param args string[]
local function set_lint_target(args)
    vim.list_extend(args, {
        "--all-features",
        "--examples",
        "--benches",
        "--tests",
        "--workspace",
    })
end

---@param args string[]
local function set_output_style(args)
    vim.list_extend(args, {
        "--quiet",
        "--message-format",
        "json-diagnostic-short",
    })
end

---@param args string[]
---@return boolean
local function set_root_dir(args)
    local root_dir = get_rust_analyzer_root_dir()
    if root_dir then
        vim.list_extend(args, {
            -- avoid collapsing to rust-analyzer and something else..
            -- by using other other directory
            "--target-dir",
            root_dir .. "/target/check", -- intentionaly use check not clippy
            "--manifest-path",
            root_dir .. "/Cargo.toml",
        })
        return true
    else
        -- vim.notify_once("root dir notfound")
    end
    return false
end

function M.check()
    local args = { "check" }
    set_output_style(args)
    set_lint_target(args)
    set_root_dir(args)

    return {
        cmd = "cargo",
        args = args,
        stream = "stdout", -- read from stdout.
        stdin = false, -- cargo check does not read stdin.
        append_fname = false, -- cargo check does not need filename.
        ignore_exitcode = true, -- cargo check return err code when they emit error, so ignore.
        parser = M.parser,
    }
end

function M.clippy()
    local args = { "clippy" }
    set_output_style(args)
    set_lint_target(args)
    set_root_dir(args)
    return {
        cmd = "cargo",
        args = args,
        stream = "stdout", -- read from stdout.
        stdin = false, -- cargo clippy does not read stdin.
        append_fname = false, -- cargo clippy does not need filename.
        ignore_exitcode = true, -- cargo clippy return err code when they emit error, so ignore.
        parser = M.parser,
    }
end

---Register cargo to nvim-lint
---@param force boolean?
function M.register(force)
    -- automatically re_register when rust_analyzer is attached.
    if not already_registered then
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "automatically re_register when rust_analyzer is attached.",
            pattern = "*.rs",
            callback = function(args)
                if vim.lsp.get_client_by_id(args.data.client_id).name ~= "rust_analyzer" then
                    return
                end
                M.register(true)
                local is_ok, lint = pcall(require, "lint")
                if is_ok then
                    lint.try_lint()
                end
            end,
        })
    end

    if force or not already_registered then -- privent double register
        local is_ok, lint = pcall(require, "lint")
        if is_ok then
            lint.linters.cargo_check = M.check
            lint.linters.cargo_clippy = M.clippy
            already_registered = true
        else
            vim.notify_once("failed to setup cargo lint, nvim-lint is not found.", vim.log.levels.ERROR)
        end
    else
        vim.notify_once("cargo linters are already registered to nvim-lint", vim.log.levels.WARN)
    end
end

return M
