require("rc.plugins.lazynvim").install()

local ok, lazy = pcall(require, "lazy")

if not ok then
    print("Failed to load lazy.nvim")
    return
end

---@type LazySpec[]
local plugins = {
    {
        "antoinemadec/FixCursorHold.nvim",
        config = function() vim.g.cursorhold_updatetime = 200 end,
    },

    {
        "tomasiser/vim-code-dark",
        lazy = true,
    },

    "machakann/vim-sandwich",

    {
        "goolord/alpha-nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
    },

    {
        "levouh/tint.nvim",
        dependencies = require("rc.plugins.config.tint_nvim").after,
        config = require("rc.plugins.config.tint_nvim").config,
    },

    {
        "folke/noice.nvim",
        config = require("rc.plugins.config.noice_nvim").config,
        dependencies = require("rc.plugins.config.noice_nvim").dependencies,
    },

    {
        "rcarriga/nvim-notify",
        config = require("rc.plugins.config.notify").config,
    },

    "stevearc/dressing.nvim",

    {
        "folke/which-key.nvim",
        setup = require("rc.plugins.config.which-key").setup,
        config = require("rc.plugins.config.which-key").config,
    },

    {
        "stevearc/stickybuf.nvim",
        config = require("rc.plugins.config.stickybuf_nvim").config,
    },

    {
        -- move window
        "sindrets/winshift.nvim",
        setup = require("rc.plugins.config.winshift").config,
    },

    -- capture command output to buffer
    "tyru/capture.vim", -- this plugin works with no configuration

    -- auto config 'tabstop', 'shiftwidth', 'softtabstop' and 'expandtab'
    "zsugabubus/crazy8.nvim", -- this plugin works with no configuration

    {
        "mbbill/undotree",
        config = function() end,
    },

    {
        "phaazon/hop.nvim",
        branch = "v1",
        config = require("rc.plugins.config.hop").config,
    },

    {
        "abecodes/tabout.nvim",
        dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
        config = function() require("tabout").setup() end,
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = require("rc.plugins.config.gitsigns").requires,
        config = require("rc.plugins.config.gitsigns").config,
    },

    {
        "numToStr/Comment.nvim",
        config = require("rc.plugins.config.Comment").config,
    },

    {
        "norcalli/nvim-colorizer.lua",
        --bug: stop working after change colorscheme
        config = function() require("colorizer").setup() end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = require("rc.plugins.config.lualine").requires,
        config = require("rc.plugins.config.lualine").config,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("rc.plugins.config.treesitter").update()
            require("rc.plugins.config.treesitter").config()
            require("rc.plugins.config.treesitter.highligh_workaround").set_hi()
        end,
    },

    "nvim-treesitter/playground",

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = require("rc.plugins.config.treesitter.context").config,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = require("rc.plugins.config.treesitter.textobj").config,
    },

    {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        config = require("rc.plugins.config.treesitter.rainbow").config,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = require("rc.plugins.config.indent_line").config,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = require("rc.plugins.config.telescope").requires,
        config = require("rc.plugins.config.telescope").config,
    },

    "neovim/nvim-lspconfig",

    {
        "williamboman/mason.nvim",
        dependencies = require("rc.plugins.config.mason").requires,
        config = require("rc.plugins.config.mason").config,
    },

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = require("rc.plugins.config.lspsaga_nvim").config,
    },

    {
        "simrat39/rust-tools.nvim",
        dependencies = require("rc.plugins.config.rust-tools").requires,
        config = require("rc.plugins.config.rust-tools").setup,
    },

    {
        "saecki/crates.nvim",
        dependencies = require("rc.plugins.config.crates_nvim").requires,
        config = require("rc.plugins.config.crates_nvim").setup,
    },

    {
        "ray-x/lsp_signature.nvim",
        config = require("rc.plugins.config.lsp-signature").config,
    },

    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = require("rc.plugins.config.lsplines").config,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        require = require("rc.plugins.config.null-ls").dependencies,
        config = require("rc.plugins.config.null-ls").config,
    },

    {
        "smjonas/inc-rename.nvim",
        after = "dressing.nvim",
        config = require("rc.plugins.config.increname").setup,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = require("rc.plugins.config.cmp").requires,
        config = require("rc.plugins.config.cmp").config,
    },

    {
        "SmiteshP/nvim-gps",
        after = "nvim-treesitter",
    },

    {
        "EthanJWright/toolwindow.nvim",
        config = require("rc.plugins.config.toolwindow_nvim").config,
    },

    {
        "akinsho/toggleterm.nvim",
        config = require("rc.plugins.config.toggleterm").config,
    },

    {
        "kevinhwang91/rnvimr",
        -- dependencies = require("rc.plugins.config.rnvimr").requires,
        config = require("rc.plugins.config.rnvimr").config,
    },

    {
        "kdheepak/lazygit.nvim",
        dependencies = require("rc.plugins.config.lazygit_nvim").requires,
        config = require("rc.plugins.config.lazygit_nvim").config,
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("diffview").setup() end,
    },

    {
        "folke/trouble.nvim",
        config = require("rc.plugins.config.trouble_nvim").config,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = require("rc.plugins.config.dap_nvim").requires,
        after = require("rc.plugins.config.dap_nvim").after,
        config = require("rc.plugins.config.dap_nvim").config,
    },

    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "python" },
        config = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
                local venv_python = string.format("%s/bin/python", venv)
                require("dap-python").setup(venv_python)
            else
                require("dap-python").setup()
            end
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    },

    "ii14/emmylua-nvim",

    {
        "gen740/SmoothCursor.nvim",
        config = require("rc.plugins.config.smooth_cursor_nvim").config,
    },
}

lazy.setup(plugins, {})
