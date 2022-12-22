local M = {}

function M.config() require("lsp_signature").setup({ hint_enable = false, always_trigger = true }) end

M.lazy = {
    "ray-x/lsp_signature.nvim",
    config = M.config,
}

return M
