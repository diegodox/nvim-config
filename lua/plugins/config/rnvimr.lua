local M = {}

-- register key map
M.keymap = function()
    local ok, whichkey = pcall(require, "which-key")
    if not ok then
        print("[Rnvimr] could not load which-key")
        vim.api.nvim_set_keymap("n", "<Leader>b", "<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>")
    else
        whichkey.register(
            { b = { "<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>", "Open ranger file manager" } },
            { prefix = "<Leader>" }
        )
    end
end

-- Function to setup
-- set vim varable
M.setup = function()
    -- Make Ranger replace Netrw and be the file explorer
    vim.g.rnvimr_enable_ex = 1

    -- Make Ranger to be hidden after picking a file
    vim.g.rnvimr_enable_picker = 1

    -- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
    vim.g.rnvimr_enable_bw = 1
end

return M
