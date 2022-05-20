local M = {}

function M.config()
    require("hop").setup()
    vim.keymap.set("n", "<C-f>", "<Cmd>HopChar1<CR>", { desc = "Hop to char" })
end

return M
