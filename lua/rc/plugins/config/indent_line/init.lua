local M = {
    fg = "#555555",
    alpha = 0.08,
    hl_indents = { "#E5C07B", "#98C379", "#56B6C2", "#61AFEF", "#C678DD", "#E06C75" },
    hl_bgs = { "#FFFF00", "#00FF00", "#00FFFF", "#0000FF", "#C678DD", "#E06C75" },
}

M.requires = "nvim-treesitter/nvim-treesitter"

local util = require("rc.plugins.config.indent_line.util")

-- set indent highlights minimal style
---@diagnostic disable-next-line: unused-local, unused-function
local function highlight_indent_blankline()
    for i, hl in ipairs(M.hl_indents) do
        vim.cmd({
            cmd = "highlight",
            args = { "IndentBlanklineIndent" .. i, "guibg=" .. hl, "gui=nocombine" },
        })
    end
end

-- set indent highlights like vscode's indent-rainbow
local function highlight_indent_rainbow(alpha, fg)
    local is_ok, normal_bg_rgb = util.get_hl_bg_rgb("Normal")
    if not is_ok then
        return
    end
    for i, hl in ipairs(M.hl_bgs) do
        local bg = util.add(alpha, normal_bg_rgb, util.hex2rgb(hl))
        vim.cmd({
            cmd = "highlight",
            args = { "IndentBlanklineIndent" .. i, "guifg=" .. fg, "guibg=" .. util.rgb2hex(bg), "gui=nocombine" },
        })
    end
end

-- settings
local function setting() vim.g.indent_blankline_show_trailing_blankline_indent = false end

-- setup indent blank line
local function setup()
    require("indent_blankline").setup({
        filetype_exclude = {
            "help",
            "startify",
            "Term",
            "packer",
            "nvim-lsp-installer",
        },
        space_char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        },
    })
end

local function autoset_highlight()
    local g = vim.api.nvim_create_augroup("AutoSetIndentBlanklineHightlight", { clear = true })
    vim.api.nvim_create_autocmd("Colorscheme", {
        group = g,
        callback = function()
            highlight_indent_rainbow(M.alpha, M.fg)
            -- highlight_indent_blankline()
            vim.notify("set indent_blankline highlights", vim.log.levels.TRACE)
        end,
        desc = "Automatically set indent_blankline highlighting after colorscheme applied",
    })
end

-- call highlight, settings, setup
function M.config()
    highlight_indent_rainbow(M.alpha, M.fg)
    -- highlight_indent_blankline()
    setting()
    setup()
    autoset_highlight()
end

M.lazy = {
    "lukas-reineke/indent-blankline.nvim",
    config = M.config,
}

return M
