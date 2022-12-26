local M = { "gen740/SmoothCursor.nvim" }

function M.config()
    require("smoothcursor").setup({
        disabled_filetypes = { "toggleterm" },
    })
end

return M
