---Setup ranger toggleterm
return function()
    local ranger = require("rc.plugins.config.toggleterm.utils").new_terminal({
        cmd = "ranger",
        direction = "float",
    })

    vim.api.nvim_create_user_command("ToggleRanger", function()
        ---@diagnostic disable-next-line: missing-parameter
        ranger:toggle()
    end, { desc = "Toggle floating ranger file manager" })

    vim.keymap.set("n", "<C-t>b", "<cmd>ToggleRanger<CR>i", { desc = "Toggle floating ranger file manager" })
end
