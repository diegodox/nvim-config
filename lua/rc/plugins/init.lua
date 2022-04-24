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
        "tomasiser/vim-code-dark",
        config = function() require('rc.plugins.config.codedark').config() end,
    }

    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

