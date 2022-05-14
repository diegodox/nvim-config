local M = {}

-- configure toggleterm.nvim
function M.config()
    if not vim.o.hidden then
        vim.notify("toggleterm needs 'hidden' option, set hidden = true", vim.log.levels.WARN)
        vim.o.hidden = true
    end
    -- error: Normalにリンクされるだろうハイライトの背景が真っ黒になる？
    --        Notifyの影響かも？
    -- require("toggleterm").setup({ float_opts = { winblend = 4 } })
    require("toggleterm").setup()
    M.term()
    M.lazygit()
    M.ranger()
end

-- setup toggleterminal
function M.term()
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
        size = 15,
        hidden = true,
        env = {
            -- open a new split in current nvim to edit, instead of opening new vim in terminal
            VISUAL = "nvr -cc split",
            EDITOR = "nvr -cc split",
        },
    })

    vim.api.nvim_create_user_command("ToggleTerm", function()
        ---@diagnostic disable-next-line: missing-parameter
        term:toggle()
    end, { desc = "Toggle terminal" })

    vim.api.nvim_create_user_command("ToggleTermVertical", function()
        local is_open = term:is_open()
        if is_open then
            term:close()
        end
        term:open(vim.o.columns * 0.4, "vertical", false)
    end, { desc = "Toggle terminal open in vertical" })

    vim.api.nvim_create_user_command("ToggleTermHorizontal", function()
        local is_open = term:is_open()
        if is_open then
            term:close()
        end
        term:open(15, "horizontal", false)
    end, { desc = "Toggle terminal open in horizontal" })

    local ok_whichkey, whichkey = pcall(require, "which-key")
    if ok_whichkey then
        whichkey.register({ ["<C-t>"] = { name = "ToggleTerm" } })
        whichkey.register({ ["<C-t>"] = { name = "ToggleTerm" } }, { mode = "t" })
    else
        vim.notify_once("Plugin 'which-key' not found\nSetup keymap without 'which-key'", vim.lsp.log_levels.INFO)
    end

    vim.keymap.set("n", "<C-t><CR>", "<cmd>ToggleTerm<CR>", { desc = "Toglle Terminal" })
    vim.keymap.set("n", "<C-t><C-CR>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
    vim.keymap.set("n", "<C-t>v", "<cmd>ToggleTermVertical<CR>", { desc = "Toggle Terminal Vertically" })
    vim.keymap.set("n", "<C-t>s", "<cmd>ToggleTermHorizontal<CR>", { desc = "Toggle Terminal Horizontally" })

    vim.keymap.set("t", "<C-t><CR>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
    vim.keymap.set("t", "<C-t><C-CR>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
    vim.keymap.set("t", "<C-t>v", "<cmd>ToggleTermVertical<CR>", { desc = "Toggle Terminal Vertically" })
    vim.keymap.set("t", "<C-t>s", "<cmd>ToggleTermHorizontal<CR>", { desc = "Toggle Terminal Horizontally" })
end

-- setup lazygit toggleterm
function M.lazygit()
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

    vim.keymap.set("n", "<Leader>gl", "<cmd>ToggleLazygit<CR>", { desc = "Toggle floating lazygit git client" })
    vim.keymap.set("n", "<C-t>g", "<cmd>ToggleLazygit<CR>", { desc = "Toggle floating lazygit git client" })
end

-- setup ranger toggleterm
function M.ranger()
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

    vim.keymap.set("n", "<C-t>b", "<cmd>ToggleRanger<CR>", { desc = "Toggle floating ranger file manager" })
end

return M
