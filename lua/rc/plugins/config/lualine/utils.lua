local M = {}

---Set timer to update tabline periodicaly
---Latency now is acceptable, but it would be better tabline also redrawn when statusline redrawn.
---See: https://github.com/nvim-lualine/lualine.nvim/wiki/FAQ#my-tabline-updates-infrequently
---@param period integer
function M.setup_timer(period)
    if _G.Tabline_timer == nil then
        _G.Tabline_timer = vim.loop.new_timer()
    else
        _G.Tabline_timer:stop()
    end
    _G.Tabline_timer:start(
        0, -- never timeout
        period, -- repeat every period ms
        vim.schedule_wrap(function() -- updater function
            vim.api.nvim_command("redrawtabline")
        end)
    )
end

---return function which replace text to 'replaced' if given text is empty
---@param replaced string
---@return function
function M.replace_empty(replaced)
    return function(str)
        if str == "" then
            return replaced
        else
            return str
        end
    end
end

---return true if vim has width more than `win_width`, otherwise, false
---@param win_width number
---@return function
function M.hide(win_width)
    return function()
        local ui = vim.api.nvim_list_uis()
        if not ui or ui[1] or ui[1]["width"] then
            return true
        end
        return ui[1]["width"] > win_width
    end
end

---return true if gps successfully setup gps module, otherwise false
---@return boolean
function M.setup_gps()
    local ok, gps_plug = pcall(require, "nvim-gps")
    if not ok then
        vim.notify_once("plugin 'nvim-gps' not found")
        return ok
    end
    M.gps_plug = gps_plug
    M.gps_plug.setup({
        separator = "  ", -- match to lualine components separators
    })
    return ok
end

M.modules = {
    icon = { -- filetype icon
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
    },

    center = { -- centerlize
        "%=",
        separator = "",
        padding = { right = 0, left = 0 },
    },

    ---configured filename module
    ---@param cfg table?
    ---@return table
    filename = function(cfg)
        return vim.tbl_extend("keep", cfg or {}, {
            "filename",
            symbols = {
                modified = " +",
                readonly = " ",
            },
        })
    end,

    tabs = {
        "tabs",
        mode = 2,
        tabs_color = {
            active = { fg = "#000000", bg = "#eeeeee", gui = "italic" },
            inactive = { fg = "#444444", bg = "#999999" },
        },
        last_separator = true,
        separator = "",
    },

    ---@param gps table
    ---@return table
    gps = function(gps)
        return { gps.get_location, cond = gps.is_available }
    end, -- gps module

    cwd = { -- current working directory
        "vim.fn.getcwd()",
        fmt = function(cwd)
            return vim.fn.pathshorten(vim.fn.substitute(cwd, os.getenv("HOME"), "~", ""))
        end,
    },

    session = { -- current session
        "vim.v.this_session",
        fmt = function(session_path)
            return M.replace_empty("[NO SESSION]")(vim.fn.fnamemodify(session_path, ":t"))
        end,
    },

    branch = { "branch", fmt = M.replace_empty("-") },
}

return M
