local M = {}

function M.config()
    require("smoothcursor").setup({
        disabled_filetypes = { "toggleterm" },
    })
end

M.lazy = {
    "gen740/SmoothCursor.nvim",
    config = M.config,
}

--return { M.lazy }
