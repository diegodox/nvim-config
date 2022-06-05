
-- Move visual line
vim.keymap.set("n", "k", "gk", { desc = "Move by visual line" })
vim.keymap.set("n", "j", "gj", { desc = "Move by visual line" })

-- Keep select while indentation
vim.keymap.set("v", ">", ">gv", { desc = "Keep select while indenting" })
vim.keymap.set("v", "<", "<gv", { desc = "Keep select while indenting" })

-- No arrowkeys
vim.keymap.set("n", "<up>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<down>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<left>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<right>", "<nop>", { desc = "No arrowkeys, use hjkl" })

-- Esc from terminal
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>", { desc = "Enter to Normal mode from Terminal mode" })

-- Easy save
vim.keymap.set("n", "<C-s>", function()
    vim.cmd("update")
end, { desc = "write buffer" })

vim.cmd("source ~/.config/nvim/winresize.vim")
