require("rc.settings")
require("rc.keymap")

require("rc.lsp-handler").define_sign()

require("rc.lazynvim").install()

require("rc.fcitx5").setup()

require("rc.utils").setup_colorscheme()
vim.cmd.colorscheme("codedark")

-- local group = vim.api.nvim_create_augroup("TestGroup", { clear = false })
-- vim.api.nvim_create_autocmd("User", {
--     callback = function()
--         vim.notify("TestUser")
--     end,
--     pattern = "TestUser",
--     group = group,
-- })
-- vim.keymap.set("n", "<Leader>sl", function()
--     vim.api.nvim_exec_autocmds("User", { pattern = "TestUser", group = group })
-- end, { desc = "hello" })
-- vim.keymap.set("n", "<Leader>sv", function()
--     vim.cmd("doautocmd User TestUser")
-- end, { desc = "hello" })
