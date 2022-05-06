local M = {}

M.signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

function M.def_sign()
    for type, icon in pairs(M.signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon })
    end
end

function M.keymap()
    local ok_whichkey, whichkey = pcall(require, "which-key")
    if ok_whichkey then
        whichkey.register({ l = { name = "LSP" } }, { prefix = "<Leader>" })
    elseif vim.g.whichkey then
        vim.notify_once("Plugin 'which-key' not found\nSetup keymap without 'which-key'", vim.lsp.log_levels.WARN)
    end

    vim.keymap.set("n", "<Leader>k", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
    vim.keymap.set("n", "<Leader>lh", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
    vim.keymap.set("n", "<Leader><C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature" })
    vim.keymap.set("n", "<Leader>ls", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature" })
    vim.keymap.set("n", "<Leader>l.", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
    vim.keymap.set("n", "<Leader>l,", "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", { desc = "Range Code Action" })
    vim.keymap.set("n", "<Leader>ld", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Definitions" })
    vim.keymap.set("n", "<Leader>lD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Declaration" })
    vim.keymap.set("n", "<Leader>li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Implementation" })
    vim.keymap.set("n", "<F2>", "<Cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
end

function M.config()
    M.def_sign()
    M.keymap()
end

return M
