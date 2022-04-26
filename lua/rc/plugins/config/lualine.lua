-- lualine configuration
local lualine_conf = {}

-- requirement
lualine_conf.requires = {
    "nvim-treesitter/nvim-treesitter",
    "SmiteshP/nvim-gps",
}

function lualine_conf.config()
    local gps = require("nvim-gps")

    gps.setup({
        separator = "  ",
    })

    require("lualine").setup({
        options = {
            globalstatus = true,
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_c = {
                "filename",
                { gps.get_location, cond = gps.is_available },
            },
        },
    })
end

return lualine_conf
