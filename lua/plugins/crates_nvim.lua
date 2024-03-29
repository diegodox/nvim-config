local M = { "saecki/crates.nvim", ft = "toml" }

M.dependencies = {
    "nvim-lua/plenary.nvim",
}

local function cmp_source()
    local ok, cmp = pcall(require, "cmp")
    if not ok then
        vim.notify_once("plugin 'cmp.nvim' not found, skip setup cmpletion", vim.log.levels.WARN)
        return
    end
    vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function() cmp.setup.buffer({ sources = { { name = "crates" } } }) end,
    })
end

function M.config()
    local crates = require("crates")
    crates.setup()
    cmp_source()
    crates.show()
end

return M
