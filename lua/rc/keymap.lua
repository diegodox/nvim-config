-- IME control with ESC
vim.api.nvim_set_keymap( 'n', "<Esc>", "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'i', "<Esc>", "<cmd>call system('fcitx5-remote -o > /dev/null 2>&1')<CR><Esc>", { silent = true, noremap = true } )

vim.api.nvim_set_keymap( 'n', "k", "gk", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', "j", "gj", { silent = true, noremap = true } )

vim.api.nvim_set_keymap( 'v', '>', ">gv", { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'v', '<', "<gv", { silent = true, noremap = true } )

vim.api.nvim_set_keymap( 'n', '<up>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<down>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<left>', '<nop>', { silent = true, noremap = true } )
vim.api.nvim_set_keymap( 'n', '<right>', '<nop>', { silent = true, noremap = true } )

