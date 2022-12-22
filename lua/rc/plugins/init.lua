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

    require("rc.plugins.config.tint_nvim").lazy,

    require("rc.plugins.config.noice_nvim").lazy,

    require("rc.plugins.config.notify").lazy,

    "stevearc/dressing.nvim",

    require("rc.plugins.config.which-key").lazy,

    require("rc.plugins.config.stickybuf_nvim").lazy,

    require("rc.plugins.config.winshift").lazy,

    -- capture command output to buffer
    "tyru/capture.vim", -- this plugin works with no configuration

    -- auto config 'tabstop', 'shiftwidth', 'softtabstop' and 'expandtab'
    "zsugabubus/crazy8.nvim", -- this plugin works with no configuration

    {
        "mbbill/undotree",
        config = function() end,
    },

    require("rc.plugins.config.hop").lazy,

    {
        "abecodes/tabout.nvim",
        dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
        config = function() require("tabout").setup() end,
    },

    require("rc.plugins.config.gitsigns").lazy,

    require("rc.plugins.config.Comment").lazy,

    {
        "norcalli/nvim-colorizer.lua",
        --bug: stop working after change colorscheme
        config = function() require("colorizer").setup() end,
    },

    require("rc.plugins.config.lualine").lazy,

    require("rc.plugins.config.treesitter").lazy,

    "nvim-treesitter/playground",

    require("rc.plugins.config.treesitter.context").lazy,

    require("rc.plugins.config.treesitter.textobj").lazy,

    require("rc.plugins.config.treesitter.rainbow").lazy,

    require("rc.plugins.config.indent_line").lazy,

    require("rc.plugins.config.telescope").lazy,

    "neovim/nvim-lspconfig",

    require("rc.plugins.config.mason").lazy,

    require("rc.plugins.config.lspsaga_nvim").lazy,

    require("rc.plugins.config.rust-tools").lazy,

    require("rc.plugins.config.crates_nvim").lazy,

    require("rc.plugins.config.lsp-signature").lazy,

    require("rc.plugins.config.lsplines").lazy,

    require("rc.plugins.config.null-ls").lazy,


    require("rc.plugins.config.cmp").lazy,

    {
        "SmiteshP/nvim-gps",
        after = "nvim-treesitter",
    },

    require("rc.plugins.config.toolwindow_nvim").lazy,

    require("rc.plugins.config.toggleterm").lazy,

    require("rc.plugins.config.rnvimr").lazy,

    require("rc.plugins.config.lazygit_nvim").lazy,

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("diffview").setup() end,
    },

    require("rc.plugins.config.trouble_nvim").lazy,

    require("rc.plugins.config.dap_nvim").lazy,

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

    require("rc.plugins.config.smooth_cursor_nvim").lazy,
}

lazy.setup(plugins, {})
