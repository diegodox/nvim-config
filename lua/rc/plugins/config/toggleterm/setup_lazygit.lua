---Setup LazyGit
return function()
    local lazygit = require("rc.plugins.config.toggleterm.utils").new_terminal({
        cmd = "lazygit",
        direction = "float",
        ---@param lazygit Terminal
        on_open = function(lazygit)
            require("rc.plugins.config.toggleterm.utils").close_autocmd(
                { "WinLeave", "TabLeave" },
                lazygit,
                { desc = "Close LazyGit Before Leave Buffer", buffer = lazygit.bufnr }
            )
        end,
    })

    vim.api.nvim_create_user_command(
        "ToggleLazygit",
        function() lazygit:toggle(nil, nil) end,
        { desc = "Toggle floating lazygit git client" }
    )

    vim.keymap.set("n", "<Leader>gl", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
    vim.keymap.set("n", "<C-t>g", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
end
