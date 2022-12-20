local M = {}

-- requirement plugins for telescope
M.requires = {
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "kyazdani42/nvim-web-devicons",
    "tami5/sqlite.lua",
    "nvim-telescope/telescope-frecency.nvim",
}

---call telescope.setup
local function setup()
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

local util = require("lua.rc.plugins.config.telescope.util")
local lsp = require("lua.rc.plugins.config.telescope.lsp")
local dap = require("lua.rc.plugins.config.telescope.dap")
dap.load_extension()

M.keymap = {
    ---bind general keymap
    general = function()
        local pregister = require("rc.plugins.config.which-key").pregister
        pregister({ l = { name = "LSP" } }, { prefix = "<Leader>" }, "Setup telescope keymap without 'which-key'")
        pregister({ t = { name = "Telescope" } }, { prefix = "<Leader>" }, "Setup telescope keymap without 'which-key'")
        pregister({ g = { name = "Git" } }, { prefix = "<Leader>" }, "Setup telescope keymap without 'which-key'")

        local builtin = require("telescope.builtin")

        --Call git_files if in git directory, otherwise call find_files.
        --Smarter than my old config.
        vim.keymap.set("n", "<C-p>", function()
            local threshold = 170
            vim.fn.system("git rev-parse")
            if vim.v.shell_error == 0 then
                builtin.git_files({
                    layout_strategy = util.dynamic_layout_strategy(threshold),
                    show_untracked = true,
                })
            else
                local telescope = package.loaded.telescope
                telescope.extensions.frecency.frecency({
                    layout_strategy = util.dynamic_layout_strategy(threshold),
                })
            end
        end, { desc = "Telescope smart list files" })
        vim.keymap.set("n", "<M-p>", builtin.buffers, { desc = "Telescope List Buffers" })
        vim.keymap.set("n", "<Leader>tb", builtin.buffers, { desc = "List buffers" })
        vim.keymap.set("n", "<Leader>tB", builtin.builtin, { desc = "Find builtin features" })
        vim.keymap.set("n", "<Leader>tf", builtin.find_files, { desc = "Find file" })
        vim.keymap.set("n", "<Leader>tg", builtin.live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<Leader>tr", builtin.oldfiles, { desc = "MRU" })
        vim.keymap.set("n", "<Leader>tk", builtin.keymaps, { desc = "List Keymap" })
        vim.keymap.set("n", "<Leader>tG", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<Leader>th", builtin.help_tags, { desc = "List Helps" })
        vim.keymap.set("n", "<Leader>tH", builtin.highlights, { desc = "List Highlights" })
        vim.keymap.set("n", "<Leader>gc", builtin.git_commits, { desc = "List commits" })
        vim.keymap.set("n", "<Leader>gC", builtin.git_bcommits, { desc = "List buffer commits" })
    end,

    ---bind notifications list keybindings
    notify = function()
        require("rc.plugins.config.which-key").pregister(
            { t = { name = "Telescope" } },
            { prefix = "<Leader>" },
            "Setup telescope notify keymap without 'which-key'"
        )

        local notify = require("telescope").extensions.notify
        vim.keymap.set("n", "<Leader>tn", notify.notify, { desc = "List notifications" })
    end,

    ---Debugger Adapter Protocol
    dap = dap.keymap,

    lsp = lsp.keymap,
}

-- configure telescope (setup, keymap)
function M.config()
    setup()
    M.keymap.general()
    M.keymap.notify()
end

return M
