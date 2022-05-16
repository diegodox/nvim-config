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
        vim.notify_once("plugin 'telescope' not found", vim.log.levels.WARN)
        return
    elseif not ok_actions then
        vim.notify_once("plugin 'telescope' found, but 'telescope.actions' not found", vim.log.levels.WARN)
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

M.keymap = {
    ---bind general keymap
    general = function()
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

        local ok_whichkey, whichkey = pcall(require, "which-key")
        if ok_whichkey then
            whichkey.register({ l = { name = "LSP" } }, { prefix = "<Leader>" })
            whichkey.register({ t = { name = "Telescope" } }, { prefix = "<Leader>" })
            whichkey.register({ g = { name = "git" } }, { prefix = "<Leader>" })
        else
            vim.notify_once("Plugin 'which-key' not found\nSetup keymap without 'which-key'", vim.lsp.log_levels.WARN)
        end

        vim.keymap.set("n", "<Leader>tb", "<Cmd>Telescope buffers<CR>", { desc = "List buffers" })
        vim.keymap.set("n", "<Leader>tB", "<Cmd>Telescope builtin<CR>", { desc = "Find builtin features" })
        vim.keymap.set("n", "<Leader>tf", "<Cmd>Telescope find_files<CR>", { desc = "Find file" })
        vim.keymap.set("n", "<Leader>tg", "<Cmd>Telescope live_grep<CR>", { desc = "Live grep" })
        vim.keymap.set("n", "<Leader>tG", "<Cmd>Telescope git_files<CR>", { desc = "Git files" })
        vim.keymap.set("n", "<Leader>tr", "<Cmd>Telescope oldfiles<CR>", { desc = "MRU" })
        vim.keymap.set("n", "<Leader>tk", "<Cmd>Telescope keymaps<CR>", { desc = "List Keymap" })

        vim.keymap.set("n", "<Leader>gc", "<Cmd>Telescope git_commits<CR>", { desc = "List commits" })
        vim.keymap.set("n", "<Leader>gC", "<Cmd>Telescope git_bcommits<CR>", { desc = "List buffer commits" })
    end,

    ---bind notifications list keybindings
    notify = function()
        require("telescope").load_extension("notify")

        local ok_whichkey, whichkey = pcall(require, "which-key")
        if ok_whichkey then
            whichkey.register({ t = { name = "Telescope" } }, { prefix = "<Leader>" })
        end
        vim.keymap.set("n", "<Leader>tn", "<Cmd>Telescope notify<CR>", { desc = "List notifications" })
    end,

    ---bind telescope's lsp keybinding to buffer
    ---@param bufnr number
    lsp = function(bufnr)
        vim.keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", { desc = "Definitions", buffer = bufnr })
        vim.keymap.set(
            "n",
            "gD",
            "<Cmd>Telescope lsp_type_definitions<CR>",
            { desc = "Type definitions", buffer = bufnr }
        )
        vim.keymap.set("n", "gI", "<Cmd>Telescope lsp_implementations<CR>", { desc = "Implementation", buffer = bufnr })
        vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", { desc = "References", buffer = bufnr })
        vim.keymap.set(
            "n",
            "g@",
            "<Cmd>Telescope lsp_document_symbols<CR>",
            { desc = "Document Symbols", buffer = bufnr }
        )
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
    end,
}

-- configure telescope (setup, keymap)
function M.config()
    M.setup()
    M.keymap.general()
    M.keymap.notify()
end

return M
