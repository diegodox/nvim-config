---Setup LazyGit
return function()
    local lazygit = require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        env = {
            -- open a new tab in current nvim to edit, instead of opening new vim in lazygit
            VISUAL = "nvr --remote-tab +'set bufhidden=wipe'",
            EDITOR = "nvr --remote-tab +'set bufhidden=wipe'",
        },
    })

    vim.api.nvim_create_user_command("ToggleLazygit", function()
        ---@diagnostic disable-next-line: missing-parameter
        lazygit:toggle()
    end, { desc = "Toggle floating lazygit git client" })

    vim.keymap.set("n", "<Leader>gl", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
    vim.keymap.set("n", "<C-t>g", "<cmd>ToggleLazygit<CR>i", { desc = "Toggle floating lazygit git client" })
end
