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
    require("which-key").register({
        k = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        ["<C-k>"] = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
    }, { prefix = "<Leader>" })
    require("which-key").register({
        l = {
            name = "lsp",
            h = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
            s = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
            ["."] = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
            [","] = { "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
        },
    }, { prefix = "<Leader>" })
    require("which-key").register({ ["<F2>"] = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" } })
end

function M.config()
    M.def_sign()
    M.keymap()
end

return M
