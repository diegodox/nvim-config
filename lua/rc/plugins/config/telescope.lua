local M = {}

-- requirement plugins for telescope
M.requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
}

-- call telescope.setup
function M.setup()
    local ok_telescope, telescope = pcall(require, "telescope")
    local ok_actions, actions = pcall(require, "telescope.actions")
    if not ok_telescope then
        print("plugin 'telescope' not found")
        return
    elseif not ok_actions then
        print("plugin 'telescope' found, but 'telescope.actions' not found")
        return
    end
    telescope.setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            layout_strategy = "horizontal",
            layout_defaults = {
                horizontal = {
                    mirror = false,
                    preview_width = 0.5,
                },
                vertical = {
                    mirror = false,
                },
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
                        ["<C-z>"] = "delete_buffer",
                    },
                },
            },
        },
    })
end

function M.set_keymap()
    vim.api.nvim_set_keymap(
        "n",
        "<C-p>",
        "<Cmd>lua require('telescope.builtin').find_files()<cr>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<M-p>",
        "<Cmd>lua require('telescope.builtin').buffers()<CR>",
        { noremap = true, silent = true }
    )
    local whichkey = require("which-key")
    whichkey.register({
        d = { "<Cmd>Telescope lsp_definitions<CR>", "Definitions" },
        t = { "<Cmd>Telescope lsp_type_definitions<CR>", "Type definitions" },
        I = { "<Cmd>Telescope lsp_implementations<CR>", "Goto implementation" },
        r = { "<Cmd>Telescope lsp_references<CR>", "References" },
        ["@"] = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        w = { "<Cmd>Telescope lsp_document_symbols<CR>", "Workspace Document Symbols" },
        ["."] = { "<Cmd>Telescope lsp_code_actions<CR>", "Code Action" },
        [","] = { "<Cmd>Telescope lsp_range_code_actions<CR>", "Range Code Action" },
    }, { prefix = "g" })
    whichkey.register({
        t = {
            name = "Telescope",
            b = { "<Cmd>Telescope buffers<CR>", "List buffers" },
            B = { "<Cmd>Telescope builtin<CR>", "Find builtin features" },
            f = { "<Cmd>Telescope find_files<CR>", "Find file" },
            g = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
            G = { "<Cmd>Telescope git_files<CR>", "Git files" },
            r = { "<Cmd>Telescope oldfiles<CR>", "MRU" },
            k = { "<Cmd>Telescope keymaps<CR>", "Keymap" },
        },
    }, { prefix = "<Leader>" })
    whichkey.register({
        g = {
            name = "git",
            c = { "<Cmd>Telescope git_commits<CR>", "List commits" },
            C = { "<Cmd>Telescope git_bcommits<CR>", "List buffer commits" },
        },
    }, { prefix = "<Leader>" })
end

function M.setup_notify()
    require("telescope").load_extension("notify")
    local whichkey = require("which-key")
    whichkey.register({
        t = {
            name = "Telescope",
            n = { "<Cmd>Telescope notify<CR>", "List notifications" },
        },
    }, { prefix = "<Leader>" })
end

-- configure telescope (setup, keymap)
function M.config()
    M.setup()
    M.set_keymap()
    M.setup_notify()
end

return M
