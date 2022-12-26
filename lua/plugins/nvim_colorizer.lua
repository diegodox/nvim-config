--bug: stop working after change colorscheme
local M = {}

function M.config() require("colorizer").setup() end

M.lazy = {
    "norcalli/nvim-colorizer.lua",
    config = M.config,
}

return { M.lazy }
