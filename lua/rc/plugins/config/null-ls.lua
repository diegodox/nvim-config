-- config moudle for null-ls
local M = {}

-- required plugins to run null-ls
M.requires = { "nvim-lua/plenary.nvim", "lewis6991/gitsigns.nvim" }

-- configure null-ls
function M.config()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
        vim.notify_once("plugin 'null-ls' not found, skip setup", vim.lsp.log_levels.WARN)
        return
    end

    local lsphandler = require("rc.lsp-handler")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.code_actions.gitsigns,
        },
        capabilities = lsphandler.capabilities(),
        on_attach = lsphandler.on_attach,
    })
end

return M
