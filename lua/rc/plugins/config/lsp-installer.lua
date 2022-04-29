local M = {}

M.servers = {
    "rust_analyzer",
    "sumneko_lua",
    "clangd",
}

M.enhance_server_opts = {
    ["sumneko_lua"] = function(opts)
        opts.on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end

        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Use StyLua instead of sumneko_lua builtin formatter.
                format = { enable = false },
            },
        }
    end,
}

function M.server_setup(server)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    else
        vim.notify("fail to update capabilities via 'cmp_nvim_lsp'", vim.log.levels.WARN)
    end

    local opts = {
        capabilities = capabilities,
        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
                local aug_lsp_formatting = vim.api.nvim_create_augroup(
                    "LspFormatting-" .. client.name,
                    { clear = false }
                )
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = aug_lsp_formatting,
                    callback = function()
                        vim.lsp.buf.formatting_sync()
                        vim.notify("formatted via " .. client.name, vim.log.levels.DEBUG)
                    end,
                    buffer = 0,
                })
                vim.notify(
                    "lsp formater " .. client.name .. " set to buffer " .. vim.api.nvim_buf_get_name(0),
                    vim.log.levels.TRACE
                )
            end
        end,
    }

    if M.enhance_server_opts[server.name] then
        M.enhance_server_opts[server.name](opts)
    end

    server:setup(opts)
end

function M.config()
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.on_server_ready(function(server)
        M.server_setup(server)
    end)

    for _, name in pairs(M.servers) do
        local is_server_found, server = lsp_installer.get_server(name)
        if not is_server_found then
            vim.notify("LSP: " .. name .. " is not found", vim.log.levels.WARN)
        elseif server:is_installed() then
            vim.notify("LSP: " .. name .. " is already installed", vim.lsp.log_levels.TRACE)
        else
            vim.notify("Installing LSP: " .. name, vim.log.levels.INFO)
            server:install()
        end
    end
end

return M
