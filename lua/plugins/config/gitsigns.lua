local M = {}

function M.config()
    local ok, gitsigns = pcall(require, "gitsigns")
    if not ok then
        print("plugin 'gitsigns.nvim' not found")
        return
    end
    gitsigns.setup {
        current_line_blame = true,
        current_line_blame_opts = { delay = 100 },
    }
end

return M
