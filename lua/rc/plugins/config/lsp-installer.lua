local M = {}

M.servers = {
    "rust_analyzer",
    "sumneko_lua",
    "clangd",
}

function M.server_setup(server)
    local opts = {}
    if server.name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
        }
    end
    server:setup(opts)
    vim.cmd([[do User LspAttachBuffers]])
end

function M.config()
    local lsp_installer = require("nvim-lsp-installer")

    lsp_installer.on_server_ready(
        function(server)
            M.server_setup(server)
        end
    )

    for _, name in pairs(M.servers) do
        local is_server_found, server = lsp_installer.get_server(name)
        if not is_server_found then
            print("LSP: " .. name .. " is not found")
        elseif server:is_installed() then
            -- print("LSP: " .. name .. " is already installed")
        else
            -- print("Installing LSP: " .. name)
            server:install()
        end
    end
end

return M
