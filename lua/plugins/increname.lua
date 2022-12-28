---@type LazySpec
local M = { "smjonas/inc-rename.nvim" }
M.enabled = false

M.dependencies = { "stevearc/dressing.nvim" }

function M.config()
    require("inc_rename").setup({
        input_buffer_type = "dressing",
    })
end

function M.increname() return ":IncRename " .. vim.fn.expand("<cword>") end

return M
