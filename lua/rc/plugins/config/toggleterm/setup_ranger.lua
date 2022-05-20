---Setup ranger toggleterm
return function()
    local ranger = require("rc.plugins.config.toggleterm.utils").new_terminal({
        cmd = "ranger",
        direction = "float",
        on_open = function(term)
            -- override ranger exit keybinding to stay open
            vim.keymap.set(
                "t",
                "q",
                "<cmd>ToggleRanger<CR>",
                { desc = "Toggle floating ranger file manager", buffer = term.bufnr }
            )
        end,
    })

    vim.api.nvim_create_user_command("ToggleRanger", function()
        ranger:toggle(nil, nil)
    end, { desc = "Toggle floating ranger file manager" })

    vim.keymap.set("n", "<C-t>b", "<cmd>ToggleRanger<CR>i", { desc = "Toggle floating ranger file manager" })
end
