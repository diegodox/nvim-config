--bug: stop working after change colorscheme
---@type LazySpec
local M = { "norcalli/nvim-colorizer.lua" }

function M.config() require("colorizer").setup() end

return M
