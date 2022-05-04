local M = {}

function M.setup()
    vim.g.timeoutlen = 10
end

function M.config()
    local ok, whichkey = pcall(require, "which-key")
    if not ok then
        vim.notify_once("Plugin 'which-key' not found\nSkip setup 'which-key'", vim.lsp.log_levels.ERROR)
        return
    end
    whichkey.setup({})
end

return M
