local M = {}

function M.load_extension() require("telescope").load_extension("dap") end

---bind telescope's dap keybinding to buffer
---@param bufnr number
function M.keymap(bufnr)
    local dap = require("telescope").extensions.dap
    vim.keymap.set("n", "<Leader>dH", dap.commands, { desc = "DAP commands", bufnr = bufnr })
    vim.keymap.set("n", "<Leader>dC", dap.configurations, { desc = "DAP configurations", bufnr = bufnr })
    vim.keymap.set("n", "<Leader>dP", dap.list_breakpoints, { desc = "DAP list_breakpoints", bufnr = bufnr })
    vim.keymap.set("n", "<Leader>dV", dap.variables, { desc = "DAP variables", bufnr = bufnr })
end

return M
