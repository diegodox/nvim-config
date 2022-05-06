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

---@param bufnr number
function M.set_lsp_keymap(bufnr)
    vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", { desc = "Definitions", buffer = bufnr })
    vim.keymap.set("n", "gD", "<Cmd>Telescope lsp_type_definitions<CR>", { desc = "Type definitions", buffer = bufnr })
    vim.keymap.set("n", "gI", "<Cmd>Telescope lsp_implementations<CR>", { desc = "Implementation", buffer = bufnr })
    vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", { desc = "References", buffer = bufnr })
    vim.keymap.set("n", "g@", "<Cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols", buffer = bufnr })
    vim.keymap.set("n", "g.", "<Cmd>Telescope lsp_code_actions<CR>", { desc = "Code Action", buffer = bufnr })
    vim.keymap.set(
        "n",
        "g,",
        "<Cmd>Telescope lsp_range_code_actions<CR>",
        { desc = "Range Code Action", buffer = bufnr }
    )
    vim.keymap.set(
        "n",
        "gw",
        "<Cmd>Telescope lsp_workspace_symbols<CR>",
        { desc = "Workspace Symbols", buffer = bufnr }
    )
end

-- configure telescope (setup, keymap)
function M.config()
    M.setup()
    M.set_keymap()
    M.setup_notify()
end

return M
