local M = {}

---@param servername string
---@return table
function M.handlers(servername)
    -- vim.api.nvim_create_autocmd("colorscheme", { callback = vim.cmd("* highlight NormalFloat guibg=#1f2335") })
    -- vim.api.nvim_create_autocmd("colorscheme", { callback = vim.cmd("* highlight FloatBorder guibg=#1f2335") })
    vim.cmd("autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335")
    vim.cmd("autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335")

    local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
    }

    -- LSP settings (for overriding per client)
    local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }
    if servername ~= "null-ls" then
        handlers["$/progress"] = require("rc.plugins.config.notify.lsp").notify_lsp_progress_handler
    end

    return handlers
end

function M.on_attach(client, bufnr)
    local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function()
            vim.lsp.buf.format({
                filter = function(clients)
                    ---@diagnostic disable: redefined-local
                    return vim.tbl_filter(function(client)
                        if type(client) ~= "table" then
                            return false
                        end
                        return client.name ~= "sumneko_lua" -- don't use sumneko_lua's formatter
                    end, clients)
                end,
                bufnr = bufnr,
            })
        end,
        desc = "Format buffer just before write",
        buffer = bufnr,
    })
    vim.notify(
        "lsp formater " .. client.name .. " set to buffer " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )

    vim.notify(
        "CursorHold diagnostic autocmd set to buffer " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )

    require("rc.plugins.config.telescope").keymap.lsp(bufnr)
    require("rc.plugins.config.lspconfig").keymap(bufnr)
end

function M.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        vim.notify("fail to update capabilities via 'cmp_nvim_lsp'", vim.log.levels.WARN)
    end
    return capabilities
end

---@param server string
---@param opts table?
---@return table
function M.server_opts(server, opts)
    opts = opts or {}
    opts = vim.tbl_deep_extend("keep", opts, {
        on_attach = M.on_attach,
        capabilities = M.capabilities(),
        handlers = M.handlers(server),
    })

    return opts
end

---@param server string
---@param opts table?
function M.server_setup(server, opts)
    local ok, lspconfig = pcall(require, "lspconfig")
    opts = M.server_opts(server, opts)
    if ok then
        lspconfig[server].setup(opts)
    else
        vim.notify("plugin 'lspconfig' not found, fail to setup server " .. server, vim.log.levels.ERROR)
    end
end

return M
