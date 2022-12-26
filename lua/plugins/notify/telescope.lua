local M = {}

---bind telescope notify keybinding to buffer
---@param bufnr number?
function M.keymap(bufnr)
    require("plugins.which-key").pregister(
        { t = { name = "Telescope" } },
        { prefix = "<Leader>" },
        "Setup telescope notify keymap without 'which-key'"
    )
    local notify = require("telescope").extensions.notify
    vim.keymap.set("n", "<Leader>tn", notify.notify, { desc = "List notifications", bufnr = bufnr })
end

return M
