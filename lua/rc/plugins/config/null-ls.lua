-- config moudle for null-ls
local M = {}

-- required plugins to run null-ls
M.requires = "nvim-lua/plenary.nvim"

-- configure null-ls
function M.config()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
        vim.notify_once("plugin 'null-ls' not found, skip setup", vim.lsp.log_levels.WARN)
        return
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local cmp_nvim_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        vim.notify_once("fail to update capabilities via 'cmp_nvim_lsp'", vim.lsp.log_levels.WARN)
    end

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
        },
        capabilities = capabilities,
        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
                local aug_lsp_formatting = vim.api.nvim_create_augroup(
                    "LspFormatting-" .. client.name,
                    { clear = false }
                )
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = aug_lsp_formatting,
                    callback = function()
                        vim.lsp.buf.formatting_sync()
                        vim.notify(
                            "formatted buffer " .. vim.api.nvim_buf_get_name(0) .. " via " .. client.name,
                            vim.lsp.log_levels.DEBUG
                        )
                    end,
                    buffer = 0,
                })
            end
        end,
    })
end

return M
