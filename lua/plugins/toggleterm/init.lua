local M = { "akinsho/toggleterm.nvim" }

---Configure toggleterm.nvim
function M.config()
    if not vim.o.hidden then
        vim.notify("toggleterm needs 'hidden' option, set hidden = true", vim.log.levels.WARN)
        vim.o.hidden = true
    end
    require("toggleterm").setup({
        start_in_insert = false,
        float_opts = { winblend = 4 },
    })
    require("plugins.toggleterm.setup_term")()
end

return M
