local M = {}
local L = {
    util = require("rc.plugins.config.telescope.util"),
    lsp = require("rc.plugins.config.telescope.lsp"),
    dap = require("rc.plugins.config.telescope.dap"),
    notify = require("rc.plugins.config.notify.telescope"),
    pregister = require("rc.plugins.config.which-key").pregister,
}

-- requirement plugins for telescope
M.requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
    "tami5/sqlite.lua",
    "nvim-telescope/telescope-frecency.nvim",
}

-- configure telescope (setup, keymap)
function M.config()
    L.setup()
    L.keymap.general()
    L.keymap.telescope()
    L.keymap.git()
    L.notify.keymap()
end

---call telescope.setup
function L.setup()
    local ok_telescope, telescope = pcall(require, "telescope")
    local ok_actions, actions = pcall(require, "telescope.actions")
    if not ok_telescope then
        vim.notify_once("plugin 'telescope' not found", vim.log.levels.WARN)
        return
    elseif not ok_actions then
        vim.notify_once("plugin 'telescope' found, but 'telescope.actions' not found", vim.log.levels.WARN)
        return
    end

    local telescope_opts = {
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
                    mirror = true,
                    preview_width = 0.7,
                },
                vertical = {
                    mirror = true,
                },
            },
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<esc>"] = actions.close,
                    ["<C-e>"] = function(prompt_bufnr, _mode)
                        require("trouble.providers.telescope").open_with_trouble(prompt_bufnr, _mode)
                    end,
                },
            },
            winblend = 7,
        },
        pickers = {
            find_files = {
                -- theme = "dropdown",
                prompt_prefix = "🔍",
            },
            git_files = {
                -- theme = "dropdown",
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
    }

    telescope.setup(telescope_opts)

    vim.cmd("highlight link TelescopeNormal NormalUntransparent")
end

L.keymap = {
    ---bind general keymap
    general = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", L.util.smart_find_file, { desc = "Telescope smart list files" })
        vim.keymap.set("n", "<M-p>", builtin.buffers, { desc = "Telescope List Buffers" })
    end,

    telescope = function()
        local builtin = require("telescope.builtin")
        L.pregister(
            { t = { name = "Telescope" } },
            { prefix = "<Leader>" },
            "Setup telescope keymap without 'which-key'"
        )
        vim.keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "List buffers" })
        vim.keymap.set("n", "<Leader>tB", builtin.builtin, { desc = "Find builtin features" })
        vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "Find file" })
        vim.keymap.set("n", "<Leader>tg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<Leader>tr", builtin.oldfiles, { desc = "MRU" })
        vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "List Keymap" })
        vim.keymap.set("n", "<Leader>tG", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "List Helps" })
        vim.keymap.set("n", "<Leader>tH", builtin.highlights, { desc = "List Highlights" })
    end,

    git = function()
        local builtin = require("telescope.builtin")
        L.pregister({ g = { name = "Git" } }, { prefix = "<Leader>" }, "Setup telescope keymap without 'which-key'")
        vim.keymap.set("n", "<Leader>gc", builtin.git_commits, { desc = "List commits" })
        vim.keymap.set("n", "<Leader>gC", builtin.git_bcommits, { desc = "List buffer commits" })
    end,
}

return M
