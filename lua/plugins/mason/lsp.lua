---@type LazySpec
local M = { "williamboman/mason-lspconfig.nvim" }

M.dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "paradoxxxzero/pyls-isort",
}

-- list of language servers which must installed and configured
local ensure_installed = { "rust_analyzer", "texlab", "lua_ls", "taplo", "clangd", "cmake", "tsserver", "html-lsp",
    "emmet_ls" }

local enhance_server_opts = {
    sumneko_lua = {
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
    clangd = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
    },
    pylsp = {
        settings = {
            pylsp = {
                configurationSources = { "pycodestyle" },
                plugins = {
                    pycodestyle = { ignore = { "E501" } },
                    autopep8 = { enabled = false },
                    flake8 = { enabled = true, ignore = { "E501" } },
                    pyflakes = { enabled = false },
                    rope_autoimport = { enabled = true },
                },
            },
        },
    },
}

---@param server string
local function setup_server(server)
    local enhance_opts = enhance_server_opts[server] or {}
    enhance_opts.on_attach = function() require("plugins.navic").on_attach() end
    require("plugins.lsp_config").setup_server(server, enhance_opts)
end

function M.config()
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
        ensure_installed = ensure_installed,
    })

    for _, lsp_name in pairs(mason_lspconfig.get_installed_servers()) do
        if lsp_name ~= "rust_analyzer" then
            setup_server(lsp_name)
        end
    end

    -- hot fix for tsserver on my mac
    setup_server('tsserver')
end

return M
