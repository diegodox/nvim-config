---@return Terminal
local function create_term()
    return require("rc.plugins.config.toggleterm.utils").new_terminal({
        size = 15,
        env = {
            -- open a new split in current nvim to edit, instead of opening new vim in terminal
            VISUAL = "nvr -cc split",
            EDITOR = "nvr -cc split",
        },
    })
end

---@param term Terminal
local function auto_close_tab_leave(term)
    -- auto close term before leave current tab
    local group = vim.api.nvim_create_augroup("AutoCloseTermTabLeave", { clear = true })
    vim.api.nvim_create_autocmd("TabLeave", {
        group = group,
        callback = function()
            term:close()
        end,
        desc = "Close ToggleTerm Before Leave Tab",
    })
end

---@param term Terminal
local function create_user_command(term)
    vim.api.nvim_create_user_command("ToggleTerm", function()
        term:toggle(nil, nil)
    end, { desc = "Toggle terminal" })

    vim.api.nvim_create_user_command("ToggleTermVertical", function()
        if term:is_open() then
            term:close()
        end
        term:open(vim.o.columns * 0.4, "vertical", false)
    end, { desc = "Toggle terminal open in vertical" })

    vim.api.nvim_create_user_command("ToggleTermHorizontal", function()
        if term:is_open() then
            term:close()
        end
        term:open(15, "horizontal", false)
    end, { desc = "Toggle terminal open in horizontal" })
end

local function set_keymap()
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

---Setup toggle terminal
return function()
    local term = create_term()
    auto_close_tab_leave(term)
    create_user_command(term)
    set_keymap()
end
