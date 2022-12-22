-- Move visual line
vim.keymap.set("n", "k", "gk", { desc = "Move by visual line" })
vim.keymap.set("n", "j", "gj", { desc = "Move by visual line" })

-- Keep select while indentation
vim.keymap.set("v", ">", ">gv", { desc = "Keep select while indenting" })
vim.keymap.set("v", "<", "<gv", { desc = "Keep select while indenting" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

-- No arrowkeys
vim.keymap.set("n", "<up>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<down>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<left>", "<nop>", { desc = "No arrowkeys, use hjkl" })
vim.keymap.set("n", "<right>", "<nop>", { desc = "No arrowkeys, use hjkl" })

-- Esc from terminal
vim.keymap.set("t", "<C-Space>", "<C-\\><C-n>", { desc = "Enter to Normal mode from Terminal mode" })

vim.keymap.set("n", "[w", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]w", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

vim.keymap.set(
    "n",
    "[e",
    function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
    { desc = "Previous Error" }
)
vim.keymap.set(
    "n",
    "]e",
    function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
    { desc = "Next Error" }
)

-- Easy save
vim.keymap.set("n", "<C-s>", function() vim.cmd("update") end, { desc = "write buffer" })

for _, k in pairs({ "+", "-", ">", "<" }) do
    vim.keymap.set("n", "<C-w>" .. k, "<C-w>" .. k .. "<Plug>(resize)", { silent = true, remap = true })
    vim.keymap.set("n", "<Plug>(resize)" .. k, "<C-w>" .. k .. "<Plug>(resize)", { silent = true })
end
vim.keymap.set("n", "<Plug>(resize)", "<Nop>", { silent = true, remap = true })

vim.keymap.set("c", "<F1>", "q")
vim.keymap.set("c", "<F2>", "w")
vim.keymap.set("c", "<F3>", "e")
vim.keymap.set("c", "<F4>", "r")
vim.keymap.set("c", "<F5>", "t")
vim.keymap.set("c", "<F6>", "y")
vim.keymap.set("c", "<F7>", "u")
vim.keymap.set("c", "<F8>", "i")
vim.keymap.set("c", "<F9>", "o")
vim.keymap.set("c", "<F10>", "p")
