local M = {}

function M.config()
    require("trouble").setup({
        action_keys = {
            close = { "q", "<C-t><C-t>" },
            open_tab = { "<S-t>" },
        },
    })
end

M.lazy = {
    "folke/trouble.nvim",
    config = M.config,
}

return M
