local M = {}

function M.config()
    local lint = require("lint")
    require("rc.plugins.config.nvimlint.cargo").register()
    lint.linters_by_ft = {
        rust = { "cargo_clippy" },
    }
    vim.api.nvim_create_autocmd("BufReadPost", {
        desc = "Try run lint for new buffer",
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function()
            lint.try_lint()
        end,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
        desc = "Try update lint for saved buffer",
        group = vim.api.nvim_create_augroup("NvimLint", { clear = false }),
        callback = function()
            vim.notify("run lint!")
            lint.try_lint()
        end,
    })
end

return M
