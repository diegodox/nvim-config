-- config moudle for null-ls
local M = {}

-- required plugins to run null-ls
M.requires = "nvim-lua/plenary.nvim"

-- configure null-ls
function M.config()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
        print("plugin 'null-ls' not found")
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_nvim_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        print("fail to update capabilities via 'cmp_nvim_lsp'")
    end

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
        },
        capabilities = capabilities,
        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
                vim.cmd([[
                augroup LspFormatting
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                augroup END
                ]])
            end
        end,
    })
end

return M
