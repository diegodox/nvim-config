---Setup ranger toggleterm
return function()
    local ranger = require("toggleterm.terminal").Terminal:new({
        cmd = "ranger",
        direction = "float",
        hidden = true,
        env = {
            -- open a new tab in current nvim to edit, instead of opening new vim in ranger
            VISUAL = "nvr --remote-tab",
            EDITOR = "nvr --remote-tab",
        },
    })

    vim.api.nvim_create_user_command("ToggleRanger", function()
        ---@diagnostic disable-next-line: missing-parameter
        ranger:toggle()
    end, { desc = "Toggle floating ranger file manager" })

    vim.keymap.set("n", "<C-t>b", "<cmd>ToggleRanger<CR>i", { desc = "Toggle floating ranger file manager" })
end
