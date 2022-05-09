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
        config = function()
            vim.g.cursorhold_updatetime = 200
        end,
    })

    use({
        "tomasiser/vim-code-dark",
        setup = require("rc.plugins.config.codedark").autocmd(),
        config = function()
            vim.cmd([[colorscheme codedark]])
        end,
    })

    use({
        "goolord/alpha-nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    })

    use({
        "rcarriga/nvim-notify",
        config = function()
            require("rc.plugins.config.notify").config()
        end,
    })


    use({

    use({
        "folke/which-key.nvim",
        setup = function()
            require("rc.plugins.config.which-key").setup()
        end,
        config = function()
            require("rc.plugins.config.which-key").config()
        end,
    })

    -- simple but AMAZING!!!!
    -- this plugin works with no configuration
    use("tyru/capture.vim")

    use({
        "phaazon/hop.nvim",
        after = "which-key.nvim",
        branch = "v1",
        config = function()
            require("rc.plugins.config.hop").config()
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        after = "which-key.nvim",
        config = function()
            require("rc.plugins.config.gitsigns").config()
        end,
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("rc.plugins.config.Comment").config()
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    use({
        -- "nvim-lualine/lualine.nvim",
        "diegodox/lualine.nvim",
        branch = "tabline-last-sepalator",
        requires = require("rc.plugins.config.lualine").requires,
        config = function()
            require("rc.plugins.config.lualine").config()
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = require("rc.plugins.config.treesitter").run,
        config = function()
            require("rc.plugins.config.treesitter").config()
        end,
    })

    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        config = function()
            require("rc.plugins.config.treesitter-rainbow").config()
        end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        after = "nvim-treesitter",
        config = function()
            require("rc.plugins.config.indent_blankline").config()
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        after = "which-key.nvim",
        requires = require("rc.plugins.config.telescope").requires,
        config = function()
            require("rc.plugins.config.telescope").config()
        end,
    })

    use({
        "neovim/nvim-lspconfig",
        after = "which-key.nvim",
        config = function()
            require("rc.plugins.config.lspconfig").config()
        end,
    })

    use({
        "williamboman/nvim-lsp-installer",
        after = { "nvim-lspconfig", "cmp-nvim-lsp" },
        config = function()
            require("rc.plugins.config.lsp-installer").config()
        end,
    })

    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = { "nvim-lspconfig", "cmp-nvim-lsp" },
        require = require("rc.plugins.config.null-ls").requires,
        config = function()
            require("rc.plugins.config.null-ls").config()
        end,
    })

    use({
        "hrsh7th/nvim-cmp",
        requires = require("rc.plugins.config.cmp").requires,
        setup = function()
            require("rc.plugins.config.cmp").setting()
        end,
        config = function()
            require("rc.plugins.config.cmp").config()
        end,
    })

    use({
        "akinsho/toggleterm.nvim",
        after = "which-key.nvim",
        config = function()
            require("rc.plugins.config.toggleterm").config()
        end,
    })

    -- Automatic setup plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
