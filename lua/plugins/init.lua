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
        "tomasiser/vim-code-dark",
        config = function() vim.cmd [[colorscheme codedark]] end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
            vim.g.timeoutlen = 100
        end
    }

    use {
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        after = { "which-key.nvim" } ,
        config = function() require('lua.plugins.config.gitsigns').config() end,
    }

    use {
        "numToStr/Comment.nvim",
        config = function() require('lua.plugins.config.Comment').config() end,
    }

    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require('colorizer').setup() end,
    }

    use {
        "kdheepak/lazygit.nvim",
        config = function() require('plugins.config.lazygit').keymap() end
    }

    use {
        "kevinhwang91/rnvimr",
        after = "which-key.nvim",
        setup = function() require('plugins.config.rnvimr').setup() end,
        config = function() require('plugins.config.rnvimr').config() end,
    }

    use {
        "nvim-lualine/lualine.nvim",
        after = colorscheme,
        config = function() require("lualine").setup() end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = require('lua.plugins.config.treesitter').run,
        config = function() require('lua.plugins.config.treesitter').config() end,
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        after = 'nvim-treesitter',
        config = function() require('lua.plugins.config.indent_blankline').config() end,
    }

    -- use {
    --     "p00f/nvim-ts-rainbow",
    --     after = { "nvim-treesitter" },
    --     config = function()
    --         require("nvim-treesitter.configs").setup {
    --             rainbow = {
    --                 colors = {
    --                     "#FFD700",
    --                     "#87CEFA",
    --                     "#DA70D6",
    --                 },
    --             },
    --         }
    --     end
    -- }

    -- telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = function() require('plugins.config.telescope').requires() end,
        config = function() require('plugins.config.telescope').config() end,
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
        config = function()
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
            require('which-key').register(
                { k = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover" } },
                { prefix = "<Leader>" }
            )
        end
    }

    use {
        "williamboman/nvim-lsp-installer",
        -- after = { "nvim-lspconfig", "nvim-cmp" },
        after = { "nvim-lspconfig" },
        config = function()
            local lsp_installer = require("nvim-lsp-installer")

            local servers = {
                "rust_analyzer",
                "sumneko_lua",
                "clangd",
            }

            lsp_installer.on_server_ready(function(server)
                local opts = {}
                server:setup(opts)
                vim.cmd([[do User LspAttachBuffers]])
            end)

            for _, name in pairs(servers) do
                local is_server_found, server = lsp_installer.get_server(name)
                if not is_server_found then
                    print("LSP: " .. name .. " is not found")
                elseif server:is_installed() then
                    -- print("LSP: " .. name .. " is already installed")
                else
                    -- print("Installing LSP: " .. name)
                    server:install()
                end
            end
        end
    }

    -- use {
    --     "hrsh7th/nvim-cmp",
    --     requires = require('plugins.config.cmp').requires,
    --     config = require('plugins.config.cmp').config,
    -- }

    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

