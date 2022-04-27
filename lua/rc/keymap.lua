-- IME control with ESC
vim.api.nvim_set_keymap(
    "n",
    "<Esc>",
    "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>",
    { silent = true, noremap = true, desc = "Have IME(fcitx5) to english mode with ESC" }
)
vim.api.nvim_set_keymap(
    "i",
    "<Esc>",
    "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>",
    { silent = true, noremap = true, desc = "Have IME(fcitx5) to english mode when escape from insert mode" }
)

-- Move visual line
vim.api.nvim_set_keymap("n", "k", "gk", { silent = true, noremap = true, desc = "Move by visual line" })
vim.api.nvim_set_keymap("n", "j", "gj", { silent = true, noremap = true, desc = "Move by visual line" })

-- Keep select while indentation
vim.api.nvim_set_keymap("v", ">", ">gv", { silent = true, noremap = true, desc = "Keep select while indenting" })
vim.api.nvim_set_keymap("v", "<", "<gv", { silent = true, noremap = true, desc = "Keep select while indenting" })

-- No arrowkeys
vim.api.nvim_set_keymap("n", "<up>", "<nop>", { silent = true, noremap = true, desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<down>", "<nop>", { silent = true, noremap = true, desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<left>", "<nop>", { silent = true, noremap = true, desc = "No arrowkeys, use hjkl" })
vim.api.nvim_set_keymap("n", "<right>", "<nop>", { silent = true, noremap = true, desc = "No arrowkeys, use hjkl" })

-- Esc from terminal
vim.api.nvim_set_keymap(
    "t",
    "<C-Space>",
    "<C-\\><C-n>",
    { noremap = true, silent = true, desc = "Enter to Normal mode from Terminal mode" }
)
