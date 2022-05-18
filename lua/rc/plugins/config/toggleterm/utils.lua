local M = {}

---create a new terminal oblject appling my deafult settings
---setting: hidden, EDITOR as new tab.
---@param term Terminal?
---@return Terminal
function M.new_terminal(term)
    term = term or {}
    vim.tbl_deep_extend("keep", term, {
        hidden = true,
        env = {
            -- open a new tab in current nvim to edit, instead of opening new vim in ranger
            VISUAL = "nvr --remote-tab",
            EDITOR = "nvr --remote-tab",
        },
    })
    return require("toggleterm.terminal").Terminal:new(term)
end

return M
