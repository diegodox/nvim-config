local M = {}

function M.config() require("tabout").setup() end
M.lazy = {
    "abecodes/tabout.nvim",
    dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" },
    config = M.confgi(),
}

--return { M.lazy }
