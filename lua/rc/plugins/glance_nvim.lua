local M = {}

local function autoset_highlight()
    local g = vim.api.nvim_create_augroup("AutoSetGlanceHightlight", { clear = true })
    vim.api.nvim_create_autocmd("Colorscheme", {
        group = g,
        callback = function()
            require("glance.highlights").setup()
            vim.notify("set glance highlights", vim.log.levels.TRACE)
        end,
        desc = "Automatically set glance highlighting after colorscheme applied",
    })
end

function M.config()
    require("glance").setup()
    autoset_highlight()
end

M.lazy = { "dnlhc/glance.nvim", config = M.config, lazy = true, event = "CursorHold" }

return M
