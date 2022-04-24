-- IME control with ESC
vim.api.nvim_set_keymap( 'n', "<Esc>", "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'i', "<Esc>", "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>", { silent = true, noremap = true } )

-- Move visual line
vim.api.nvim_set_keymap( 'n', "k", "gk", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', "j", "gj", { silent = true, noremap = true } )

-- Keep select while indentation
vim.api.nvim_set_keymap( 'v', '>', ">gv", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'v', '<', "<gv", { silent = true, noremap = true } )

-- No arrowkeys
vim.api.nvim_set_keymap( 'n', '<up>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<down>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<left>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<right>', '<nop>', { silent = true, noremap = true } )

vim.api.nvim_set_keymap( 'c', '<up>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'c', '<down>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'c', '<left>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'c', '<right>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'c', '<Tab>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'c', '<S-Tab>', '<nop>', { silent = true, noremap = true } )

-- Esc from terminal
vim.api.nvim_set_keymap(
    "t",
    "<C-Space>",
    "<C-\\><C-n>",
    {noremap = true, silent = true}
)

