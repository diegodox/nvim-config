local M = {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
}

function M.config()
    require("lsp_lines").setup()

    -- Disable virtual_text since it's redundant due to lsp_lines.
    vim.diagnostic.config({
        virtual_text = false,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function() M.hide_diagnostic() end,
    })

    vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "i:*",
        callback = function() M.show_diagnostic() end,
    })
end

---@param name string
---@return number?
local function get_namespace_by_name(name)
    local nss = vim.diagnostic.get_namespaces()
    for key, ns in pairs(nss or {}) do
        if ns and ns.name == name then
            assert(type(key) == "number")
            return key
        end
    end
end

---@param name string?
---@param config table[]?
---@param should_fallback boolean?
function M.show_diagnostic(name, config, should_fallback)
    local ns = name and get_namespace_by_name(name)
    if should_fallback or ns then
        vim.diagnostic.show(ns, 0, nil, config)
    end
end

---@param name string?
---@param should_fallback boolean?
function M.hide_diagnostic(name, should_fallback)
    local ns = name and get_namespace_by_name(name)
    if should_fallback or ns then
        vim.diagnostic.hide(ns, 0)
    end
end

function M.highlight()
    local g = vim.api.nvim_create_augroup("LspLinesHighlight", { clear = true })
    vim.api.nvim_create_autocmd(
        "ColorScheme",
        { command = "highlight! default link DiagnosticVirtualTextHint NonText", group = g }
    )
end

return M
