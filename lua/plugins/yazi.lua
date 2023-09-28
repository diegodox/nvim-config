---@type LazySpec
local M = { "DreamMaoMao/yazi.nvim" }
M.enabled = true

M.dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
}
M.keys = {
    { "<C-b>", "<cmd>Yazi<CR>", desc = "Toggle Yazi" },
}

return M
