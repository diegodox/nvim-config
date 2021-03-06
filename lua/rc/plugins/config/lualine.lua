local M = {} -- lualine configuration

M.requires = { -- requirement plugins for lualine
    "nvim-treesitter/nvim-treesitter",
    "SmiteshP/nvim-gps",
    "kyazdani42/nvim-web-devicons",
}

-- return function which replace text to 'replaced' if given text is empty
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
        local ui = vim.api.nvim_list_uis()
        if not ui then
            return true
        end
        return ui[1]["width"] > win_width
    end
end

-- configure lualine
function M.config()
    local gps = require("nvim-gps")

    gps.setup({
        separator = "  ", -- match to lualine components separators
    })

    local icon = { -- filetype icon
        "filetype",
        icon_only = true,
        colors = false,
        separator = "",
        padding = { right = 0, left = 1 },
        fmt = function(str)
            local icon = require("nvim-web-devicons")
            if not icon.get_icon(vim.fn.expand("%:t"), vim.bo.filetype) then
                return nil
            end
            return str
        end,
    }

    local center = { -- centerlize
        "%=",
        separator = "",
        padding = { right = 0, left = 0 },
    }

    require("lualine").setup({
        options = {
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {},
            lualine_c = { icon, { "filename", path = 1 } },
            lualine_x = { "diff", "diagnostics" },
            lualine_y = {},
            lualine_z = {},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { icon, { "filename", path = 1 } },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_a = { { "branch", fmt = replace_empty("-") } },
            lualine_b = { -- Only if tabline has plenty of space, show encoding/fileformat/filetype.
                { "encoding", cond = hide(200) },
                { "fileformat", cond = hide(200) },
                { "filetype", cond = hide(200) },
            },
            lualine_c = { center, icon, "filename", { gps.get_location, cond = gps.is_available } },
            lualine_x = { { "diff", cond = hide(150) } }, -- Only if tabline has enough space, show diff.
            lualine_y = { { "location", cond = hide(200) } }, -- Only if tabline has plenty of space, show location.
            lualine_z = {
                { -- current working directory
                    "vim.fn.getcwd()",
                    fmt = function(cwd)
                        return vim.fn.pathshorten(vim.fn.substitute(cwd, os.getenv("HOME"), "~", ""))
                    end,
                },
                { -- current session
                    "vim.v.this_session",
                    fmt = function(session_path)
                        return replace_empty("[NO SESSION]")(vim.fn.fnamemodify(session_path, ":t"))
                    end,
                },
            },
        },
    })

    -- Set timer to update tabline periodicaly
    -- Latency now is acceptable, but it would be better tabline also redrawn when statusline redrawn.
    -- See: https://github.com/nvim-lualine/lualine.nvim/wiki/FAQ#my-tabline-updates-infrequently
    if _G.Tabline_timer == nil then
        _G.Tabline_timer = vim.loop.new_timer()
    else
        _G.Tabline_timer:stop()
    end
    _G.Tabline_timer:start(
        0, -- never timeout
        300, -- repeat every {num} ms
        vim.schedule_wrap(function() -- updater function
            vim.api.nvim_command("redrawtabline")
        end)
    )
end

return M
