local M = {}

M.dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
}

function M.config()
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
        lsp = {
            signature = { enabled = false },
            hover = { enabled = false },
        },
        notify = { enabled = false },
        presets = { inc_rename = true },
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

---@type LazySpec
M.lazy = {
    "folke/noice.nvim",
    config = M.config,
    dependencies = M.dependencies,
}

return { M.lazy }
