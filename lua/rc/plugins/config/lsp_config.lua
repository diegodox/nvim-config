local M = {}

---@param bufnr number
function M.on_attach_keymap(bufnr)
    require("rc.lsp-handler").keymap(bufnr)
    require("rc.plugins.config.telescope").keymap.lsp(bufnr)
end

---@param capabilities table<string, string|table|boolean|function> capabilities
---@return table<string, string|table|boolean|function> capabilities
function M.update_capabilities(capabilities)
    return require("rc.plugins.config.cmp").update_capabilities(capabilities)
end

---@param server string
---@param opts table?
---@return table opts
function M.server_opts(server, opts)
    local lsphandler = require("rc.lsp-handler")
    opts = opts or {}
    opts = vim.tbl_deep_extend("keep", opts, {
        on_attach = function(client, bufnr)
            lsphandler.on_attach_format(client, bufnr)
            if client.supports_method("textDocument/documentHighlight") then
                lsphandler.auto_highlight_document(bufnr)
            end
            M.on_attach_keymap(bufnr)
        end,
        capabilities = M.update_capabilities(lsphandler.capabilities()),
        handlers = lsphandler.handlers(server),
    })
    return opts
end

---@param server string
---@param opts table?
function M.setup_server(server, opts)
    local lspconfig = require("lspconfig")
    opts = M.server_opts(server, opts)
    lspconfig[server].setup(opts)
end

return M
