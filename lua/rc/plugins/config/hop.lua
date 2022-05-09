local M = {}

function M.config()
    require("hop").setup()
    vim.keymap.set("n", "f", "<Cmd>HopChar1<CR>", { desc = "Hop to char after cursor" })
    vim.keymap.set("n", "F", "<Cmd>HopChar1<CR>", { desc = "Hop to char before cursor" })
end

return M
