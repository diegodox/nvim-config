local M = {}

M.signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

local function def_sign()
    for type, icon in pairs(M.signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon })
    end
end

local function open_diagnostic()
    vim.diagnostic.open_float(nil, { focusable = true })
end

---Set general LSP keybinding
---@param bufnr number
function M.keymap(bufnr)
    require("rc.plugins.config.which-key").pregister(
        { l = { name = "LSP" } },
        { prefix = "<Leader>" },
        "Setup LSP keymap without 'which-key' bufnr: " .. bufnr
    )
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.hover, { desc = "Hover", buffer = bufnr })
    vim.keymap.set("n", "<Leader><C-k>", vim.lsp.buf.signature_help, { desc = "Signature", buffer = bufnr })
    vim.keymap.set("n", "<Leader>ls", vim.lsp.buf.signature_help, { desc = "Signature", buffer = bufnr })
    vim.keymap.set("n", "<Leader>l.", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })
    vim.keymap.set("n", "<Leader>l,", vim.lsp.buf.range_code_action, { desc = "Range Code Action", buffer = bufnr })
    vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition, { desc = "Definitions", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = bufnr })
    vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lw", open_diagnostic, { desc = "Diagnostic", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format", buffer = bufnr })
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
end

function M.config()
    def_sign()
end

return M
