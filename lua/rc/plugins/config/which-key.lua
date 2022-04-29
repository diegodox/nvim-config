local M = {}

function M.setup()
    vim.g.timeoutlen = 10
end

function M.config()
    local ok, whichkey = pcall(require, "which-key")
    if not ok then
        vim.notify_once("plugin 'which-key' not found, skip setup 'which-key'", vim.lsp.log_levels.ERROR)
        return
    end
    whichkey.setup({})
end

return M
