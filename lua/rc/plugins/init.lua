require("rc.plugins.packer_install").install()

local ok, packer = pcall(require, "packer")

if not ok then
    print("Failed to load packer.nvim")
    return
end

require("rc.plugins.packer_init").init(packer)

--
-- Install plugins
--
return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use({
        "antoinemadec/FixCursorHold.nvim",
        config = function() vim.g.cursorhold_updatetime = 200 end,
    })

    use({
        "tomasiser/vim-code-dark",
        setup = function() require("rc.utils").setup_colorscheme() end,
        config = function() vim.cmd.colorscheme("codedark") end,
    })

    use("machakann/vim-sandwich")

    use({
        "goolord/alpha-nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("alpha").setup(require("alpha.themes.startify").config) end,
    })

    use({
        "levouh/tint.nvim",
        after = {
            "vim-code-dark",
            "dressing.nvim",
            "alpha-nvim",
            "lualine.nvim",
            "gitsigns.nvim",
        },
        config = function() require("rc.plugins.config.tint_nvim").config() end,
    })

    use({
        "folke/noice.nvim",
        config = function() require("rc.plugins.config.noice_nvim").config() end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    })

    use({
        "rcarriga/nvim-notify",
        config = function() require("rc.plugins.config.notify").config() end,
    })

    use("stevearc/dressing.nvim")

    use({
        "folke/which-key.nvim",
        setup = function() require("rc.plugins.config.which-key").setup() end,
        config = function() require("rc.plugins.config.which-key").config() end,
    })

    use({
        "stevearc/stickybuf.nvim",
        config = function() require("rc.plugins.config.stickybuf_nvim").config() end,
    })

    use({
        -- move window
        "sindrets/winshift.nvim",
        setup = function() require("rc.plugins.config.winshift").config() end,
    })

    -- capture command output to buffer
    use("tyru/capture.vim") -- this plugin works with no configuration

    -- auto config 'tabstop', 'shiftwidth', 'softtabstop' and 'expandtab'
    use("zsugabubus/crazy8.nvim") -- this plugin works with no configuration

    use({
        "mbbill/undotree",
        config = function() end,
    })

    use({
        "phaazon/hop.nvim",
        branch = "v1",
        config = function() require("rc.plugins.config.hop").config() end,
    })

    use({
        "abecodes/tabout.nvim",
        after = "nvim-cmp",
        config = function()
            ---@diagnostic disable-next-line: missing-parameter
            require("tabout").setup()
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        requires = require("rc.plugins.config.gitsigns").requires,
        config = function() require("rc.plugins.config.gitsigns").config() end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function() require("rc.plugins.config.Comment").config() end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            --bug: stop working after change colorscheme
            require("colorizer").setup()
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        after = "nvim-navic",
        requires = require("rc.plugins.config.lualine").requires,
        config = function() require("rc.plugins.config.lualine").config() end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function() require("rc.plugins.config.treesitter").run() end,
        config = function()
            require("rc.plugins.config.treesitter").config()
            require("rc.plugins.config.treesitter.highligh_workaround").set_hi()
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter-context",
        config = function() require("rc.plugins.config.treesitter-context").config() end,
    })

    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        config = function() require("rc.plugins.config.treesitter-rainbow").config() end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("rc.plugins.config.indent_line").config() end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = require("rc.plugins.config.telescope").requires,
        config = function() require("rc.plugins.config.telescope").config() end,
    })

    use("neovim/nvim-lspconfig")

    use({
        "williamboman/mason.nvim",
        requires = require("rc.plugins.config.mason").requires,
        config = function() require("rc.plugins.config.mason").config() end,
    })

    use({
        "simrat39/rust-tools.nvim",
        requires = require("rc.plugins.config.rust-tools").requires,
        config = function() require("rc.plugins.config.rust-tools").setup() end,
    })

    use({
        "saecki/crates.nvim",
        requires = require("rc.plugins.config.crates_nvim").requires,
        config = function() require("rc.plugins.config.crates_nvim").setup() end,
    })

    use({
        "ray-x/lsp_signature.nvim",
        config = function() require("rc.plugins.config.lsp-signature").config() end,
    })

    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function() require("rc.plugins.config.lsplines").config() end,
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        require = require("rc.plugins.config.null-ls").requires,
        config = function() require("rc.plugins.config.null-ls").config() end,
    })

    use({
        "smjonas/inc-rename.nvim",
        after = "dressing.nvim",
        config = function() require("rc.plugins.config.increname").setup() end,
    })

    use({
        "hrsh7th/nvim-cmp",
        requires = require("rc.plugins.config.cmp").requires,
        config = function() require("rc.plugins.config.cmp").config() end,
    })

    use({
        "SmiteshP/nvim-gps",
        after = "nvim-treesitter",
    })

    use({
        "EthanJWright/toolwindow.nvim",
        config = function() require("rc.plugins.config.toolwindow_nvim").config() end,
    })

    use({
        "akinsho/toggleterm.nvim",
        config = function() require("rc.plugins.config.toggleterm").config() end,
    })

    use({
        "kevinhwang91/rnvimr",
        -- requires = require("rc.plugins.config.rnvimr").requires,
        config = function() require("rc.plugins.config.rnvimr").config() end,
    })

    use({
        "kdheepak/lazygit.nvim",
        requires = require("rc.plugins.config.lazygit_nvim").requires,
        config = function() require("rc.plugins.config.lazygit_nvim").config() end,
    })

    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("diffview").setup() end,
    })

    use({
        "folke/trouble.nvim",
        config = function() require("rc.plugins.config.trouble_nvim").config() end,
    })

    use({
        "rcarriga/nvim-dap-ui",
        requires = require("rc.plugins.config.dap_nvim").requires,
        after = require("rc.plugins.config.dap_nvim").after,
        config = function() require("rc.plugins.config.dap_nvim").config() end,
    })

    use({
        "https://github.com/mfussenegger/nvim-dap-python",
        requires = "mfussenegger/nvim-dap",
        ft = "python",
        config = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
                local venv_python = string.format("%s/bin/python", venv)
                require("dap-python").setup(venv_python)
            else
                require("dap-python").setup()
            end
        end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use("ii14/emmylua-nvim")

    use({
        "gen740/SmoothCursor.nvim",
        config = function() require("rc.plugins.config.smooth_cursor_nvim").config() end,
    })

    -- Automatic setup plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
