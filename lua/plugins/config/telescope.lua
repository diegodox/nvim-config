local M = {}

-- requirement plugins for telescope
M.requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
}

-- call telescope.setup
M.setup = function()
    local actions = require("telescope.actions")
    require("telescope").setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            layout_strategy = "horizontal",
            layout_defaults = {
                horizontal = {
                    mirror = false,
                    preview_width = 0.5
                },
                vertical = {
                    mirror = false
                }
            },
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<esc>"] = actions.close,
                },
            },
        },
        pickers = {
            find_files = {
                prompt_prefix = "🔍",
            },
            buffers = {
                mappings = {
                    i = {
                        ["<C-z>"] = "delete_buffer"
                    }
                },
            }
        }
    }
end

M.set_keymap = function()
    vim.api.nvim_set_keymap(
        "n",
        "<C-p>",
        "<Cmd>lua require('telescope.builtin').find_files()<cr>",
        {noremap = true, silent = true}
    )
    vim.api.nvim_set_keymap(
        "n",
        "<M-p>",
        "<Cmd>lua require('telescope.builtin').buffers()<CR>",
        {noremap = true, silent = true}
    )
end

-- configure telescope
-- setup, keymap
M.config = function()
    M.setup()
    M.set_keymap()
end

return M
