local M = {}

M.requires = { "simrat39/rust-tools.nvim", "mattn/webapi-vim" }

-- list of language servers which must installed and configured
local ensure_installed = { "rust_analyzer", "sumneko_lua", "pyright", "texlab", "taplo", "clangd", "cmake" }

local enhance_server_opts = {
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

---@param server string
local function server_setup(server)
    local enhance_opts = enhance_server_opts[server]
    require("rc.plugins.config.lsp_config").server_setup(server, enhance_opts)
end

function M.config()
    local lsp_isntaller = require("nvim-lsp-installer")
    lsp_isntaller.setup({
        ensure_installed = ensure_installed, -- ensure these servers are always installed
        automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
        ui = {
            border = "rounded",
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    for _, lsp in pairs(lsp_isntaller.get_installed_servers()) do
        local lsp_name = lsp.name
        if lsp_name == "rust_analyzer" then -- setup rust_analyzer with rust-tools
            local cfg = {
                tools = { inlay_hints = { highlight = "NonText" } },
                server = require("rc.plugins.config.lsp_config").server_opts("rust_analyzer", {
                    -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
                    settings = {
                        -- To enable rust-analyzer settings, visit: https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                        -- Sometimes this is better resource: https://github.com/simrat39/rust-tools.nvim/wiki/Server-Configuration-Schema
                        ["rust-analyzer"] = {
                            cargo = { allFeatures = true },
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--examples", "--tests", "--benches" },
                                allFeatures = true,
                            },
                        },
                    },
                }),
            }
            require("rust-tools").setup(cfg)
        else
            server_setup(lsp_name)
        end
    end
end

return M
