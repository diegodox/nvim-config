local M = {}

M.ensure_installed = { "rust_analyzer", "sumneko_lua" }

M.enhance_server_opts = {
    ["sumneko_lua"] = {
        settings = {
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
        },
    },
}

function M.server_setup(server)
    local enhance_opts = M.enhance_server_opts[server]
    require("rc.lsp-handler").server_setup(server, enhance_opts)
end

function M.config()
    require("nvim-lsp-installer").setup({
        ensure_installed = M.ensure_installed, -- ensure these servers are always installed
        automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    for _, lsp in pairs(M.ensure_installed) do
        M.server_setup(lsp)
    end
end

return M
