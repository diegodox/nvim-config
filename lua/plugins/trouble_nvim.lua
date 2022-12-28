---@type LazySpec
local M = { "folke/trouble.nvim" }

function M.config()
    require("trouble").setup({
        action_keys = {
            close = { "q", "<C-t><C-t>" },
            open_tab = { "<S-t>" },
        },
    })
end

return M
