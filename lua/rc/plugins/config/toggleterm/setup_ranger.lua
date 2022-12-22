---Setup ranger toggleterm
return function()
    local ranger = require("rc.plugins.config.toggleterm.utils").new_terminal({
        cmd = "ranger",
        direction = "float",
        env = {
            VISUAL = "nvr -cc 'do User RangerClose' --remote ",
            EDITOR = "nvr -cc 'do User RangerClose' --remote ",
            -- EDITOR = "nvim --server " .. vim.v.servername .. " --remote +'do User RangerClose' ",
            -- EDITOR = "nvim --server " .. vim.v.servername .. " --remote +'do User RangerClose' ",
            NVIM_REMOTE = vim.v.servername,
        },
        ---@param ranger Terminal
        on_open = function(ranger)
            -- override ranger exit keybinding to stay open
            vim.keymap.set(
                "t",
                "q",
                "<cmd>ToggleRanger<CR>",
                { desc = "Toggle floating ranger file manager", buffer = ranger.bufnr }
            )
            require("rc.plugins.config.toggleterm.utils").close_autocmd(
                { "WinLeave", "TabLeave" },
                ranger,
                { desc = "Close Ranger Before Leave Buffer", buffer = ranger.bufnr }
            )
            require("rc.plugins.config.toggleterm.utils").close_autocmd(
                "User",
                ranger,
                { desc = "Close Ranger User Autocmd", pattern = "RangerClose" }
            )
        end,
    })

    vim.api.nvim_create_user_command(
        "ToggleRanger",
        function() ranger:toggle(nil, nil) end,
        { desc = "Toggle floating ranger file manager" }
    )

    vim.keymap.set("n", "<C-t>b", "<cmd>ToggleRanger<CR>i", { desc = "Toggle floating ranger file manager" })
end
