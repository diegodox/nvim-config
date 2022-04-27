local M = {}

function M.config()
    if not vim.o.hidden then
        print("toggleterm need 'hidden' option, now hidden = true")
        vim.o.hidden = true
    end
    require("toggleterm").setup()
    M.lazygit()
end

function M.lazygit()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
    })

    function _LAZYGIT_TOGGLE()
        lazygit:toggle()
    end

    require("which-key").register({
        g = {
            name = "git",
            l = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        },
    }, { prefix = "<Leader>" })
end

return M
