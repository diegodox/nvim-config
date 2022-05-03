local M = {}

function M.config()
    local notify = require("notify")
    notify.setup({
        -- hack: set this since "notify-nvim" warn if background_colour has tranparency(default is `Normal`).
        background_colour = "CursorLine",
        timeout = 1000,
        max_width = function()
            return math.floor(vim.api.nvim_list_uis()[1]["width"] / 3)
        end,
        max_height = function()
            return math.floor(vim.api.nvim_list_uis()[1]["height"] / 4)
        end,
    })
    -- override default vim notification service (which is a message)
    vim.notify = notify
end

return M
