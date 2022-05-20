local M = {}

M.requires = { "simrat39/rust-tools.nvim", "mattn/webapi-vim" }

-- list of language servers which must installed and configured
M.ensure_installed = { "rust_analyzer", "sumneko_lua", "pyright", "texlab", "taplo", "clangd", "cmake" }

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
    ["clangd"] = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
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
        if lsp == "rust_analyzer" then -- setup rust_analyzer with rust-tools
            local cfg = {
                tools = { inlay_hints = { highlight = "NonText" } },
                server = {
                    on_attach = require("rc.lsp-handler").on_attach,
                    capabilities = require("rc.lsp-handler").capabilities(),
                    settings = {
                        -- To enable rust-analyzer settings, visit: https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                        ["rust-analyzer"] = { checkOnSave = { command = { "clippy", "--all" } } },
                    },
                },
            }
            require("rust-tools").setup(cfg)
        else
            M.server_setup(lsp)
        end
    end
end

return M
