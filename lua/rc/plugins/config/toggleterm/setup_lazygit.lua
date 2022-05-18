---Setup LazyGit
return function()
    local lazygit = require("rc.plugins.config.toggleterm.utils").new_terminal({
        cmd = "lazygit",
        direction = "float",
    })

    vim.api.nvim_create_user_command("ToggleLazygit", function()
        ---@diagnostic disable-next-line: missing-parameter
        lazygit:toggle()
    end, { desc = "Toggle floating lazygit git client" })

    vim.keymap.set("n", "<Leader>gl", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
    vim.keymap.set("n", "<C-t>g", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
end
