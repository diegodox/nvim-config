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
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
        },
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
