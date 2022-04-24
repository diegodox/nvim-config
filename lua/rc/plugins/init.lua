require('rc.plugins.packer_install').install()

local ok, packer = pcall(require, "packer")

if not ok then
    print("Failed to load packer.nvim")
    return
end

require('rc.plugins.packer_init').init(packer)

--
-- Install plugins
--
return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "mhinz/vim-startify",
        setup = function() require('rc.plugins.config.startify').setup() end,
    }

    use {
        "tomasiser/vim-code-dark",
        config = function() require('rc.plugins.config.codedark').config() end,
    }

    use {
        "folke/which-key.nvim",
        setup = function() require('rc.plugins.config.which-key').setup() end,
        config = function() require('rc.plugins.config.which-key').config() end,
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        after = "which-key.nvim" ,
        config = function() require('rc.plugins.config.gitsigns').config() end,
    }

    use {
        "numToStr/Comment.nvim",
        config = function() require('rc.plugins.config.Comment').config() end,
    }

    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require('colorizer').setup() end,
    }

    use {
        "nvim-lualine/lualine.nvim",
        after = colorscheme,
        config = function() require("lualine").setup() end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = require('rc.plugins.config.treesitter').run,
        config = function() require('rc.plugins.config.treesitter').config() end,
    }

    use {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        config = function() require('rc.plugins.config.treesitter-rainbow').config() end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        after = 'nvim-treesitter',
        config = function() require('rc.plugins.config.indent_blankline').config() end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        after = "which-key.nvim",
        requires = require('rc.plugins.config.telescope').requires,
        config = function() require('rc.plugins.config.telescope').config() end,
    }

    use {
        "neovim/nvim-lspconfig",
        after = "which-key.nvim",
        config = function() require('rc.plugins.config.lspconfig').config() end,
    }
    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

