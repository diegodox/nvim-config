---@type LazySpec
local M = { "diegodox/fcitx5.nvim" }

function M.config() require("fcitx5").setup() end

return M
