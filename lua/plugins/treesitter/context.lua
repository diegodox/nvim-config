---@type LazySpec
local M = { "nvim-treesitter/nvim-treesitter-context" }

function M.config()
    require("treesitter-context").setup({
        patterns = {
            lua = {
                "assignment_statement",
                "field",
                "local_declaration",
                "if_statement",
                "function_call",
                "function_declaration",
            },
        },
    })
end

return M
