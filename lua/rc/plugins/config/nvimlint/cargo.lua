local M = {}

local utils = require("rc.plugins.config.nvimlint.utils")

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

    local bufnr = rust_file_bufnr(spans.file_name, manifest_path)
    if not bufnr then
        return
    end

    local diagnostic = {
        -- NOTE: seems like this bufnr have no effect?
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
    diagnostics[bufnr] = diagnostics[bufnr] or {}
    table.insert(diagnostics[bufnr], diagnostic)
end

---@param name string
---@return function "parser"
local function parser(name)
    ---Parse `cargo check`/`clippy`'s output to generate vim diagnostics.
    ---@param output string 'lines of json, which is cargo check\'s json style output'
    ---@return table 'list of diagnostics'
    return function(output)
        local diagnostics = {}
        for json in output:gmatch("[^\r\n]+") do --split lines
            local is_success, decoded = pcall(vim.json.decode, json)
            if is_success and type(decoded) == "table" and decoded.reason == "compiler-message" then
                add_message(diagnostics, decoded.message, decoded.manifest_path)
            end
        end
        --clear current rust_analyzer diagnostics
        vim.diagnostic.reset(utils.get_namespace_by_name(name), nil)
        return diagnostics
    end
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
---@param root_dir string "rust-analyzer root dir"
local function set_root_dir(args, root_dir)
    vim.list_extend(args, {
        -- avoid collapsing to rust-analyzer and something else..
        -- by using other other directory
        "--target-dir",
        root_dir .. "/target/check", -- intentionaly use check not clippy
        "--manifest-path",
        root_dir .. "/Cargo.toml",
    })
end

---@param root_dir string
---@return table "cargo clippy linter"
local function clippy_linter(root_dir)
    local args = { "clippy" }
    local name = "cargo_clippy" .. root_dir
    set_output_style(args)
    set_lint_target(args)
    set_root_dir(args, root_dir)
    return {
        name = name,
        cmd = "cargo",
        args = args,
        stream = "stdout", -- read from stdout.
        stdin = false, -- cargo clippy does not read stdin.
        append_fname = false, -- cargo clippy does not need filename.
        ignore_exitcode = true, -- cargo clippy return err code when they emit error, so ignore.
        parser = parser(name),
    }
end

---@param args table "'LspAttach' callback function args"
---@param hook function "hook function which takes clippy as arg"
local function new_clippy(args, hook)
    local lsp_client = vim.lsp.get_client_by_id(args.data.client_id)
    if lsp_client.name ~= "rust_analyzer" then
        return -- only work for rust-analyzer
    end

    local is_ok, lint = pcall(require, "lint")
    if not is_ok then
        return
    end

    if -- need rust-analyzer.workspaceFolderName
        type(lsp_client.workspaceFolders) == "table" and type(lsp_client.workspaceFolders[1].name) == "string"
    then
        local clippy = clippy_linter(lsp_client.workspaceFolders[1].name)
        lint.lint(clippy)
        -- autocmds to update clippy
        vim.api.nvim_create_autocmd("BufReadPost", {
            desc = "Run cargo clippy on file read",
            group = vim.api.nvim_create_augroup("CargoClippy", { clear = false }),
            pattern = "*.rs",
            callback = function()
                lint.lint(clippy)
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            desc = "Run cargo clippy on file save",
            group = vim.api.nvim_create_augroup("CargoClippy", { clear = false }),
            pattern = "*.rs",
            callback = function()
                lint.lint(clippy)
            end,
        })
        hook(clippy)
    end
end

---@param hook function "hook function which takes clippy as arg"
function M.configure_clippy(hook)
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "automatically add clippy  when rust_analyzer is attached.",
        group = vim.api.nvim_create_augroup("CargoLint", { clear = true }),
        pattern = "*.rs",
        callback = function(args)
            new_clippy(args, hook)
        end,
    })
end

return M
