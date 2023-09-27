---@type LazySpec
local M = { "theniceboy/joshuto.nvim" }
M.enabled = true

function M.config()
    vim.keymap.set("n", "<C-b>", "<Cmd>Joshuto<CR>", { desc = "Toggle Joshuto" })
end

return M
