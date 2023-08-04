local M = { "SmiteshP/nvim-navic", lazy = true }

--- attach navic to lsp
---@param client string
---@param bufnr number
function M.on_attach(client, bufnr)
    vim.notify(client)
    if client == "emmet_ls" then
        return
    end
    require("nvim-navic").attach(client, bufnr)
end

function M.config() require("nvim-navic").setup() end

M.lualine_widget = function()
    local navic = require("nvim-navic")

    if not M.already_setup then
        M.config()
    end

    return {
        navic.get_location,
        cond = navic.is_available,
    }
end

return M
