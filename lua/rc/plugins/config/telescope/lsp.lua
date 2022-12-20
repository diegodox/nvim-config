local M = {}

---bind telescope's lsp keybinding to buffer
---@param bufnr number
function M.keymap(bufnr)
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definitions", buffer = bufnr })
    vim.keymap.set("n", "gD", builtin.lsp_type_definitions, { desc = "Type definitions", buffer = bufnr })
    vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Implementation", buffer = bufnr })
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References", buffer = bufnr })
    vim.keymap.set("n", "g@", builtin.lsp_document_symbols, { desc = "Document Symbols", buffer = bufnr })
    vim.keymap.set("n", "gw", builtin.lsp_workspace_symbols, { desc = "Workspace Symbols", buffer = bufnr })
end

return M
