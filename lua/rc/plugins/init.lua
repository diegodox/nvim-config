local fn = vim.fn

--
-- Automatically install packer.nvim
--
local install_path = fn.stdpath("data")..'/site/pack/packer/start/packer.nvim'
-- add packer.nvim to the runtime path
-- this prevent fail on docker
vim.o.runtimepath = vim.o.runtimepath..install_path
-- install packer.nvim to intstall_path
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
         "git",
         "clone",
         "--depth",
         "1",
         "https://github.com/wbthomason/packer.nvim",
         install_path
    })
    print("packer.nvim installed to "..install_path..'\n')
end

--
-- Prevent fail on error require("packer")
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Failed to load packer.nvim")
    return
end

--
-- Have packer.nvim popup
--
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = 'rounded' }
        end
    }
}

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
        config = function()
            vim.g.timeoutlen = 100

            local ok, whichkey = pcall(require, 'which-key')
            if not ok then
                print("plugin 'which-key' not found")
                return
            end
            whichkey.setup {}
        end,
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        after = { "which-key.nvim" } ,
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
        "kdheepak/lazygit.nvim",
        config = function() require('rc.plugins.config.lazygit').keymap() end,
    }

    use {
        "kevinhwang91/rnvimr",
        after = "which-key.nvim",
        setup = function() require('rc.plugins.config.rnvimr').setup() end,
        config = function() require('rc.plugins.config.rnvimr').keymap() end,
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

    -- use {
    --     -- "LinArcX/telescope-command-palette.nvim",
    --     "diegodox/telescope-command-palette.nvim",
    --     branch = "fix-remove-category",
    --     after = { "telescope.nvim", "which-key.nvim" },
    --     config = require('lua.plugins.config.command_palette').config,
    -- }

    -- use {
    --     "xiyaowong/telescope-emoji.nvim",
    --     after = { "telescope.nvim" },
    --     config = function()
    --         require("telescope").load_extension("emoji")
    --     end
    -- }

    --
    -- LSP
    --
    use {
        "neovim/nvim-lspconfig",
        --after = "cmp-nvim-lsp",
        after = "which-key.nvim",
        config = function() require('rc.plugins.config.lspconfig').config() end,
    }

    use {
        "williamboman/nvim-lsp-installer",
        -- after = { "nvim-lspconfig", "nvim-cmp" },
        after = { "nvim-lspconfig" },
        config = function() require('rc.plugins.config.lsp-installer').config() end,
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = require('rc.plugins.config.cmp').requires,
        config = function() require('rc.plugins.config.cmp').config() end,
    }

    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

