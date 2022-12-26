local M = {}

local lspconfig = require("rc.plugins.config.mason.lsp")

M.requires = lspconfig.requires

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

---@type LazySpec
local lazy = {
    "williamboman/mason.nvim",
    dependencies = M.requires,
    config = M.config,
}

return { lazy }
