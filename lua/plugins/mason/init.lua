---@type LazySpec
local M = { "williamboman/mason.nvim" }

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
end

return M
