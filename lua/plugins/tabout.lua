---@type LazySpec
local M = { "abecodes/tabout.nvim" }

M.dependencies = { "hrsh7th/nvim-cmp", "nvim-treesitter/nvim-treesitter" }

function M.config() require("tabout").setup() end

return M
