local M = {}

local telescope = require('telescope')

function M.setup()
    telescope.setup({
        extensions = {
            command_palette = {
                { "Select entire file", ":call feedkeys('GVgg')" },
                { "Save file", ":w" },
                { "Save all files", ":wa" },
                { "Close window", ":q" },
                { "Force close window", ":q!" },
                { "Quit vim", ":qa" },
                { "Force Quit vim", ":qa!" },
                { "Live Grep 🔭", ":lua require('telescope.builtin').live_grep()", 1 },
                { "Git Files 🔭", ":lua require('telescope.builtin').git_files()", 1 },
                { "Fuuzy-find File 🔭", ":lua require('telescope.builtin').find_files()", 1 },
                { "Go to match bracket", "%" },
                { "Go to open outside bracket", "[(" },
                { "Go to close outside bracket", "])" },
                { "Equaly size split windows", ":call feedkeys('<C-w>=')" },
            }
        }
    })
    telescope.load_extension('command_palette')
end

function M.keymap()
    require("which-key").register(
        { [";"] = { "<Cmd>Telescope command_palette<CR>", "Command Palette" } },
        { prefix = "<Leader>" }
    )
end


-- configure telescope-command-palette.nvim
-- setup, keymap
M.config = function()
    M.setup()
    M.keymap()
end

return M
