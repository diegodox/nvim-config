-- config moudle for null-ls
---@type LazySpec
local M = { "jose-elias-alvarez/null-ls.nvim" }

-- required plugins to run null-ls
M.dependencies = { "nvim-lua/plenary.nvim", "lewis6991/gitsigns.nvim" }

-- configure null-ls
function M.config()
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
        vim.notify_once("plugin 'null-ls' not found, skip setup", vim.lsp.log_levels.WARN)
        return
    end

    null_ls.setup(require("plugins.lsp_config").server_opts("null-ls", {
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.fish_indent,
            null_ls.builtins.diagnostics.actionlint,
            null_ls.builtins.diagnostics.shellcheck,
            null_ls.builtins.diagnostics.fish,
        },
    }))
end

return M
