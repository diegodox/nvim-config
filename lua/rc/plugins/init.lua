require("rc.plugins.lazynvim").install()

local ok, lazy = pcall(require, "lazy")

if not ok then
    print("Failed to load lazy.nvim")
    return
end

---@type LazySpec[]
local plugins = {
    "wbthomason/packer.nvim",

    {
        "antoinemadec/FixCursorHold.nvim",
        config = function() vim.g.cursorhold_updatetime = 200 end,
    },

    {
        "tomasiser/vim-code-dark",
        setup = function() require("rc.utils").setup_colorscheme() end,
        config = function() vim.cmd.colorscheme("codedark") end,
    },

    "machakann/vim-sandwich",

    {
        "goolord/alpha-nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
    },

    {
        "levouh/tint.nvim",
        after = {
            "vim-code-dark",
            "dressing.nvim",
            "alpha-nvim",
            "lualine.nvim",
            "gitsigns.nvim",
        },
        config = function() require("rc.plugins.config.tint_nvim").config() end,
    },

    {
        "folke/noice.nvim",
        config = function() require("rc.plugins.config.noice_nvim").config() end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },

    {
        "rcarriga/nvim-notify",
        config = function() require("rc.plugins.config.notify").config() end,
    },

    "stevearc/dressing.nvim",

    {
        "folke/which-key.nvim",
        setup = function() require("rc.plugins.config.which-key").setup() end,
        config = function() require("rc.plugins.config.which-key").config() end,
    },

    {
        "stevearc/stickybuf.nvim",
        config = function() require("rc.plugins.config.stickybuf_nvim").config() end,
    },

    {
        -- move window
        "sindrets/winshift.nvim",
        setup = function() require("rc.plugins.config.winshift").config() end,
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
        config = function() require("rc.plugins.config.hop").config() end,
    },

    {
        "abecodes/tabout.nvim",
        after = "nvim-cmp",
        config = function()
            ---@diagnostic disable-next-line: missing-parameter
            require("tabout").setup()
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = require("rc.plugins.config.gitsigns").requires,
        config = function() require("rc.plugins.config.gitsigns").config() end,
    },

    {
        "numToStr/Comment.nvim",
        config = function() require("rc.plugins.config.Comment").config() end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            --bug: stop working after change colorscheme
            require("colorizer").setup()
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        after = "nvim-navic",
        dependencies = require("rc.plugins.config.lualine").requires,
        config = function() require("rc.plugins.config.lualine").config() end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        init = function() require("rc.plugins.config.treesitter").run() end,
        config = function()
            require("rc.plugins.config.treesitter").config()
            require("rc.plugins.config.treesitter.highligh_workaround").set_hi()
        end,
    },

    "nvim-treesitter/playground",

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function() require("rc.plugins.config.treesitter.context").config() end,
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function() require("rc.plugins.config.treesitter.textobj").config() end,
    },

    {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        config = function() require("rc.plugins.config.treesitter.rainbow").config() end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("rc.plugins.config.indent_line").config() end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = require("rc.plugins.config.telescope").requires,
        config = function() require("rc.plugins.config.telescope").config() end,
    },

    "neovim/nvim-lspconfig",

    {
        "williamboman/mason.nvim",
        dependencies = require("rc.plugins.config.mason").requires,
        config = function() require("rc.plugins.config.mason").config() end,
    },

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function() require("rc.plugins.config.lspsaga_nvim").config() end,
    },

    {
        "simrat39/rust-tools.nvim",
        dependencies = require("rc.plugins.config.rust-tools").requires,
        config = function() require("rc.plugins.config.rust-tools").setup() end,
    },

    {
        "saecki/crates.nvim",
        dependencies = require("rc.plugins.config.crates_nvim").requires,
        config = function() require("rc.plugins.config.crates_nvim").setup() end,
    },

    {
        "ray-x/lsp_signature.nvim",
        config = function() require("rc.plugins.config.lsp-signature").config() end,
    },

    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function() require("rc.plugins.config.lsplines").config() end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        require = require("rc.plugins.config.null-ls").dependencies,
        config = function() require("rc.plugins.config.null-ls").config() end,
    },

    {
        "smjonas/inc-rename.nvim",
        after = "dressing.nvim",
        config = function() require("rc.plugins.config.increname").setup() end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = require("rc.plugins.config.cmp").requires,
        config = function() require("rc.plugins.config.cmp").config() end,
    },

    {
        "SmiteshP/nvim-gps",
        after = "nvim-treesitter",
    },

    {
        "EthanJWright/toolwindow.nvim",
        config = function() require("rc.plugins.config.toolwindow_nvim").config() end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function() require("rc.plugins.config.toggleterm").config() end,
    },

    {
        "kevinhwang91/rnvimr",
        -- dependencies = require("rc.plugins.config.rnvimr").requires,
        config = function() require("rc.plugins.config.rnvimr").config() end,
    },

    {
        "kdheepak/lazygit.nvim",
        dependencies = require("rc.plugins.config.lazygit_nvim").requires,
        config = function() require("rc.plugins.config.lazygit_nvim").config() end,
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("diffview").setup() end,
    },

    {
        "folke/trouble.nvim",
        config = function() require("rc.plugins.config.trouble_nvim").config() end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = require("rc.plugins.config.dap_nvim").requires,
        after = require("rc.plugins.config.dap_nvim").after,
        config = function() require("rc.plugins.config.dap_nvim").config() end,
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
        config = function() require("rc.plugins.config.smooth_cursor_nvim").config() end,
    },
}

lazy.setup(plugins, {})
