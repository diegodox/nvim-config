local M = {}

function M.config()
    require("smoothcursor").setup({
        disabled_filetypes = { "toggleterm" },
    })
end

return M
