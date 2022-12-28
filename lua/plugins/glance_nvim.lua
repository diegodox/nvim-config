local M = { "dnlhc/glance.nvim", lazy = true, event = "CursorHold" }

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

return M
