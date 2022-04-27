local M = {}

function M.config()
    if not vim.o.hidden then
        print("toggleterm need 'hidden' option, now hidden = true")
        vim.o.hidden = true
    end
    require("toggleterm").setup()
end

return M
