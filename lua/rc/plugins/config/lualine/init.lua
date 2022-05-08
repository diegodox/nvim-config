local M = {} -- lualine configuration

M.requires = { -- plugins required for lualine
    "nvim-treesitter/nvim-treesitter",
    "SmiteshP/nvim-gps",
    "kyazdani42/nvim-web-devicons",
}

---configure lualine
function M.config()
    local utils = require("rc.plugins.config.lualine.utils")
    utils.setup_gps()
    local mod = utils.modules
    require("lualine").setup({
        options = {
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {},
            lualine_c = { mod.icon, mod.filename({ path = 1 }) },
            lualine_x = { "diff", "diagnostics" },
            lualine_y = {},
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { mod.icon, mod.filename({ path = 1 }) },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_a = { mod.branch },
            lualine_b = { -- Only if tabline has plenty of space, show encoding/fileformat/filetype.
                { "encoding", cond = utils.hide(200) },
                { "fileformat", cond = utils.hide(200) },
                { "filetype", cond = utils.hide(200) },
            },
            lualine_c = { mod.tabs, mod.center, mod.icon, mod.filename(), mod.gps(utils.gps_plug) },
            lualine_x = { { "diff", cond = utils.hide(150) } }, -- Only if tabline has enough space, show diff.
            lualine_y = { { "location", cond = utils.hide(200) } }, -- Only if tabline has plenty of space, show location.
            lualine_z = { mod.cwd, mod.session },
        },
    })
    utils.setup_timer(300)
end

return M
