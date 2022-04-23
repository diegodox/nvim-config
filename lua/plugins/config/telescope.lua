local M = {}

-- requirement plugins for telescope
M.requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
}

-- call telescope.setup
function M.setup()
    local ok_telescope, telescope = pcall(require, 'telescope')
    local ok_actions, actions = pcall(require, 'telescope.actions')
    if not ok_telescope then
        print("plugin 'telescope' not found")
        return
    elseif not ok_actions then
        print("plugin 'telescope' found, but 'telescope.actions' not found")
        return
    end
    telescope.setup {
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

function M.set_keymap()
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
function M.config()
    M.setup()
    M.set_keymap()
end

return M
