-- Lazy.nvim auto load plugin in lua/plugins/*.lua or lua/plugins/*/init.lua
--
-- This table is list of other plugins.
---@type LazySpec[]
return {

    -- capture command output to buffer
    "tyru/capture.vim", -- this plugin works with no configuration

    -- auto config 'tabstop', 'shiftwidth', 'softtabstop' and 'expandtab'
    "zsugabubus/crazy8.nvim", -- this plugin works with no configuration

    "nvim-treesitter/playground",

    "mbbill/undotree",

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("diffview").setup() end,
    },

    {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    },

    "ii14/emmylua-nvim",

    { "machakann/vim-sandwich" },

    { "tomasiser/vim-code-dark", lazy = true },
    { "Mofiqul/vscode.nvim", lazy = true },

    require("plugins.mason.lsp"),

    require("plugins.treesitter.context"),
    require("plugins.treesitter.rainbow"),
    require("plugins.treesitter.textobj"),

    require("plugins.dap.ui"),
    require("plugins.dap.python"),
}
