local M = {}

function M.on_attach(client, bufnr)
    local group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        callback = function()
            vim.lsp.buf.format({
                filter = function(clients)
                    ---@diagnostic disable: redefined-local
                    return vim.tbl_filter(function(client)
                        if type(client) ~= "table" then
                            return false
                        end
                        return client.name ~= "sumneko_lua" -- don't use sumneko_lua's formatter
                    end, clients)
                end,
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

    local group2 = vim.api.nvim_create_augroup("HoverDiagnostic", { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
        group = group2,
        callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
        end,
        desc = "Open diagnostic flaoting window",
        buffer = bufnr,
    })
    vim.notify(
        "CursorHold diagnostic autocmd set to buffer " .. bufnr .. ": " .. vim.api.nvim_buf_get_name(bufnr),
        vim.log.levels.TRACE
    )

    require("rc.plugins.config.telescope").keymap.lsp(bufnr)
    require("rc.plugins.config.lspconfig").keymap(bufnr)
end

function M.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        vim.notify("fail to update capabilities via 'cmp_nvim_lsp'", vim.log.levels.WARN)
    end
    return capabilities
end

---@param server string
---@param opts table?
---@return table
function M.server_opts(server, opts)
    opts = opts or {}
    opts = vim.tbl_deep_extend("keep", opts, {
        on_attach = M.on_attach,
        capabilities = M.capabilities(),
    })

    return opts
end

---@param server string
---@param opts table?
function M.server_setup(server, opts)
    local ok, lspconfig = pcall(require, "lspconfig")
    opts = M.server_opts(server, opts)
    if ok then
        lspconfig[server].setup(opts)
    else
        vim.notify("plugin 'lspconfig' not found, fail to setup server " .. server, vim.log.levels.ERROR)
    end
end

return M
