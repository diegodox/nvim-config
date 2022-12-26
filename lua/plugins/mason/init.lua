---@type LazySpec
local M = { "williamboman/mason.nvim" }

local lspconfig = require("plugins.mason.lsp")

M.dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" }

function M.config()
    require("mason").setup({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
            border = "rounded",
        },
    })
    lspconfig.config()
end

return M
