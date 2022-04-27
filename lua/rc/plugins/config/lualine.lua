-- lualine configuration
local lualine_conf = {}

-- requirement
lualine_conf.requires = {
    "nvim-treesitter/nvim-treesitter",
    "SmiteshP/nvim-gps",
    "kyazdani42/nvim-web-devicons",
}

local function replace_empty(replaced)
    return function(str)
        if str == "" then
            return replaced
        else
            return str
        end
    end
end

-- return true if vim has width more than `win_width`
-- otherwise, false
local function hide(win_width)
    return function()
        local width = vim.api.nvim_list_uis()[1]["width"]
        if not width then
            return true
        end
        return width > win_width
    end
end

function lualine_conf.config()
    local gps = require("nvim-gps")

    gps.setup({
        separator = "  ",
    })

    require("lualine").setup({
        options = {
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {},
            lualine_c = {
                {
                    "filetype",
                    icon_only = true,
                    separator = "",
                    padding = { right = 0, left = 1 },
                },
                "filename",
            },
            lualine_x = { "diff", "diagnostics" },
            lualine_y = {},
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                {
                    "filetype",
                    icon_only = true,
                    colors = false,
                    separator = "",
                    padding = { right = 0, left = 1 },
                },
                "filename",
            },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_a = { { "branch", fmt = replace_empty("-") } },
            -- Only if tabline has plenty of space, show encoding/fileformat/filetype.
            lualine_b = {
                { "encoding", cond = hide(200) },
                { "fileformat", cond = hide(200) },
                { "filetype", cond = hide(200) },
            },
            lualine_c = {
                {
                    -- center this section
                    "%=",
                    separator = "",
                    padding = { right = 0, left = 0 },
                },
                {
                    "filetype",
                    icon_only = true,
                    separator = "",
                    padding = { right = 0, left = 1 },
                },
                "filename",
                { gps.get_location, cond = gps.is_available },
            },
            -- Only if tabline has space, show diff.
            lualine_x = { { "diff", cond = hide(150) } },
            -- Only if tabline has plenty of space, show location.
            lualine_y = { { "location", cond = hide(200) } },
            lualine_z = {
                {
                    -- current working directory
                    "vim.fn.getcwd()",
                    fmt = function(cwd)
                        return vim.fn.pathshorten(vim.fn.substitute(cwd, os.getenv("HOME"), "~", ""))
                    end,
                },
                {
                    -- current session
                    "vim.v.this_session",
                    fmt = function(session_path)
                        return replace_empty("[NO SESSION]")(vim.fn.fnamemodify(session_path, ":t"))
                    end,
                },
            },
        },
    })

    -- Set timer to update tabline every 1000ms
    -- Latency now is acceptable but, it would be better tabline also redrawn when statusline redrawn.
    -- See: https://github.com/nvim-lualine/lualine.nvim/wiki/FAQ#my-tabline-updates-infrequently
    if _G.Tabline_timer == nil then
        _G.Tabline_timer = vim.loop.new_timer()
    else
        _G.Tabline_timer:stop()
    end
    _G.Tabline_timer:start(
        0, -- never timeout
        1000, -- repeat every 1000 ms
        vim.schedule_wrap(function() -- updater function
            vim.api.nvim_command("redrawtabline")
        end)
    )
end

return lualine_conf
