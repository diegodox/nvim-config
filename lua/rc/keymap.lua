-- IME control with ESC
vim.keymap.set(
    "n",
    "<Esc>",
    "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>",
    { desc = "Turn IME(fcitx5) to english mode with ESC" }
)
vim.keymap.set(
    "i",
    "<Esc>",
    "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>",
    { desc = "Turn IME(fcitx5) to english mode when escape from insert mode" }
)

-- Move visual line
vim.keymap.set("n", "k", "gk", { desc = "Move by visual line" })
vim.keymap.set("n", "j", "gj", { desc = "Move by visual line" })

-- Keep select while indentation
vim.keymap.set("v", ">", ">gv", { desc = "Keep select while indenting" })
vim.keymap.set("v", "<", "<gv", { desc = "Keep select while indenting" })

-- No arrowkeys
vim.api.nvim_set_keymap("n", "<up>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<down>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<left>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<right>", "<nop>", { desc = "No arrowkeys, use hjkl" })

-- Esc from terminal
vim.api.nvim_set_keymap(
    "t",
    "<C-Space>",
    "<C-\\><C-n>",
    { noremap = true, silent = true, desc = "Enter to Normal mode from Terminal mode" }
)

vim.cmd([[source ~/.config/nvim/winresize.vim]])
