---@type LazySpec
local M = { "lukas-reineke/indent-blankline.nvim" }

local fg = "#555555"
local alpha = 0.08
local hl_indents = { "#E5C07B", "#98C379", "#56B6C2", "#61AFEF", "#C678DD", "#E06C75" }
local hl_bgs = { "#FFFF00", "#00FF00", "#00FFFF", "#0000FF", "#C678DD", "#E06C75" }

M.dependencies = { "nvim-treesitter/nvim-treesitter" }

local util = require("plugins.indent_line.util")

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
            -- util.highlight_indent_rainbow(alpha, fg, hl_bgs)
            util.highlight_indent_blankline(hl_indents)
            vim.notify("set indent_blankline highlights", vim.log.levels.TRACE)
        end,
        desc = "Automatically set indent_blankline highlighting after colorscheme applied",
    })
end

-- call highlight, settings, setup
function M.config()
    -- util.highlight_indent_rainbow(alpha, fg, hl_bgs)
    util.highlight_indent_blankline(hl_indents)
    setting()
    setup()
    autoset_highlight()
end

return M
