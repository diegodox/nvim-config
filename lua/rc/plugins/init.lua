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

    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

