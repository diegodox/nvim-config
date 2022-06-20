local M = {} -- lualine configuration

M.requires = { -- plugins required for lualine
    "nvim-treesitter/nvim-treesitter",
    "SmiteshP/nvim-gps",
    "kyazdani42/nvim-web-devicons",
}

---configure lualine
function M.config()
    vim.o.showtabline = 0

    local utils = require("rc.plugins.config.lualine.utils")
    utils.highlight_autocmd()
    utils.setup_gps()
    local mod = utils.modules
    require("lualine").setup({
        options = {
            section_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode", mod.branch },
            lualine_b = {
                mod.icon,
                mod.filename(),
            },
            lualine_c = {
                mod.center,
                mod.signature_label,
            },
            lualine_x = { "diff", mod.workspace_diagnostics },
            lualine_y = { { "location", cond = utils.hide(200) }, mod.tabs, mod.ime_status },
            lualine_z = {
                mod.cwd, --[[ mod.session ]]
            },
        },
        inactive_winbar = {
            lualine_a = { mod.icon, mod.filename({ path = 1 }) },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        winbar = {
            lualine_a = { mod.icon, mod.filename({ path = 1 }) },
            lualine_b = {},
            lualine_c = { mod.gps(utils.gps_plug) },
            lualine_x = {
                { "encoding", cond = utils.hide(200) },
                { "fileformat", cond = utils.hide(200) },
                { "filetype", cond = utils.hide(200) },
                "diff",
                "diagnostics",
            },
            lualine_y = {},
            lualine_z = {},
        },
    })
    utils.setup_statusline_timer(300)
end

return M
