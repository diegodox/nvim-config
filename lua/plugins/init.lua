return {

    -- capture command output to buffer
    "tyru/capture.vim", -- this plugin works with no configuration

    -- auto config 'tabstop', 'shiftwidth', 'softtabstop' and 'expandtab'
    "zsugabubus/crazy8.nvim", -- this plugin works with no configuration

    "nvim-treesitter/playground",

    "neovim/nvim-lspconfig",

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

    {
        "Mofiqul/vscode.nvim",
        lazy = true,
    },

    { "machakann/vim-sandwich" },
}
