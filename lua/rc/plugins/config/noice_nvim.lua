local M = {}

M.dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
}

function M.config()
    ---@type NoiceConfig
    local config = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
        },
        lsp = { signature = { enabled = false } },
    }
    require("noice").setup(config)
end

---noice lualine module
function M.lualine()
    local modules = {}

    local ok_noice, noice = pcall(require, "noice")
    if not ok_noice then
        vim.notify_once("failed to load noice")
        return modules
    end

    -- neovim macro recording message
    ---@type LualineModule
    modules.recording = {
        noice.api.statusline.mode.get,
        cond = noice.api.statusline.mode.has,
        color = { fg = "#ff9e64" },
    }
    return modules
end

return M
