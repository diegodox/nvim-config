local M = {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
}

local is_enable = true

function M.config()
    require("lsp_lines").setup()

    -- Disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({ virtual_text = false })

    vim.api.nvim_create_user_command("ToggleLspLines", M.toggle, { desc = "Toggle lsp_lines show/hide" })
end

function M.disable_on_insert()
    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function() M.hide() end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "i:*",
        callback = function() M.show() end,
    })
end

function M.toggle()
    if is_enable then
        M.hide()
    else
        M.show()
    end
end

function M.show()
    vim.diagnostic.config({ virtual_lines = true })
    is_enable = true
end

function M.hide()
    vim.diagnostic.config({ virtual_lines = false })
    is_enable = false
end

function M.highlight()
    local g = vim.api.nvim_create_augroup("LspLinesHighlight", { clear = true })
    vim.api.nvim_create_autocmd(
        "ColorScheme",
        { command = "highlight! default link DiagnosticVirtualTextHint NonText", group = g }
    )
end

return M
