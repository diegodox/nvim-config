local M = {}

M.requires = { "nvim-lua/plenary.nvim" }

function M.config()
    vim.g.lazygit_floating_window_winblend = 5
    vim.keymap.set("n", "<Leader>gl", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
    vim.keymap.set("n", "<C-g>", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
end

M.lazy = {
    "kdheepak/lazygit.nvim",
    dependencies = M.requires,
    config = M.config,
}

return { M.lazy }
