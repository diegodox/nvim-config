local M = {}

function M.config()
    local lint = require("lint")
    -- require("rc.plugins.config.nvimlint.cargo").configure_clippy(function(clippy)
    --     require("rc.plugins.config.lsplines").cargo_autocmd(clippy.name)
    -- end)
    lint.linters_by_ft = {}
    vim.api.nvim_create_autocmd("BufReadPost", {
        desc = "Try run lint for new buffer",
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function() lint.try_lint() end,
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
