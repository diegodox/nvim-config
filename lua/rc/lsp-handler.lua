local M = {}

function M.define_sign()
    for type, icon in pairs({
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon })
    end
end

function M.def_reference_highlight()
    vim.cmd("highlight LspReferenceText guibg=#464646")
    vim.cmd("highlight LspReferenceRead guibg=#464646")
    vim.cmd("highlight LspReferenceWrite guibg=#464646 gui=underline")
    vim.notify("Lsp reference highlight set", vim.log.levels.TRACE)
end

---Set general LSP keybinding
---@param bufnr number
function M.keymap(bufnr)
    local function open_diagnostic() vim.diagnostic.open_float(nil, { focusable = true }) end
    local increname = require("rc.plugins.config.increname").increname
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
    vim.keymap.set("n", "<Leader>ld", vim.lsp.buf.definition, { desc = "Definitions", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lD", vim.lsp.buf.declaration, { desc = "Declaration", buffer = bufnr })
    vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation, { desc = "Implementation", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lw", open_diagnostic, { desc = "Diagnostic", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format", buffer = bufnr })
    vim.keymap.set("n", "<F2>", increname, { desc = "Rename", buffer = bufnr, expr = true })
end

---@param bufnr number
function M.auto_highlight_document(bufnr)
    local g = vim.api.nvim_create_augroup("document_highlight", { clear = false })

    vim.api.nvim_create_autocmd("CursorHold", {
        callback = vim.lsp.buf.document_highlight,
        group = g,
        buffer = bufnr,
        desc = "Highlights symbol under cursor",
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        group = g,
        buffer = bufnr,
        desc = "Removes document highlights from current buffer.",
    })

    vim.notify(
        "lsp document highlight set to buffer: " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )
end

---@param client table
---@param bufnr number
function M.on_attach_format(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = false }),
        callback = function()
            vim.lsp.buf.format({
                bufnr = bufnr,
            })
        end,
        desc = "Format buffer just before write",
        buffer = bufnr,
    })
    vim.notify(
        "lsp formater " .. client.name .. " set to buffer " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )
end

---@return table<string, string|table|boolean|function> capabilities
function M.capabilities() return vim.lsp.protocol.make_client_capabilities() end

return M
