local M = { "neovim/nvim-lspconfig", lazy = true }

---@param bufnr number
function M.on_attach_keymap(bufnr)
    require("rc.lsp-handler").keymap(bufnr)
    require("plugins.telescope.lsp").keymap(bufnr)
    -- require("plugins.lspsaga_nvim").keymap(bufnr)
end

---@param capabilities table<string, string|table|boolean|function> capabilities
---@return table<string, string|table|boolean|function> capabilities
function M.default_capabilities(capabilities) return require("plugins.cmp").default_capabilities(capabilities) end

---@param server string
---@param opts table?
---@return table opts
function M.server_opts(server, opts)
    local lsphandler = require("rc.lsp-handler")
    opts = opts or {}
    local on_attach_ext = opts.on_attach or function() end
    opts.on_attach = function(client, bufnr)
        lsphandler.on_attach_format(client, bufnr)
        if client.supports_method("textDocument/documentHighlight") then
            lsphandler.auto_highlight_document(bufnr)
        end
        M.on_attach_keymap(bufnr)
        on_attach_ext(client, bufnr)
        vim.lsp.inlay_hint(bufnr, true)
    end
    opts = vim.tbl_deep_extend("keep", opts, {
        capabilities = M.default_capabilities(lsphandler.capabilities()),
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
