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
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

function M.keymap()
    require("which-key").register({ k = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" } }, { prefix = "<Leader>" })
end

function M.config()
    M.def_sign()
    M.keymap()
end

return M
