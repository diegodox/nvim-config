local M = {}

function M.setup()
    vim.g.timeoutlen = 10
end

function M.config()
    local ok, whichkey = pcall(require, 'which-key')
    if not ok then
        print("plugin 'which-key' not found")
        return
    end
    whichkey.setup {}
end

return M
