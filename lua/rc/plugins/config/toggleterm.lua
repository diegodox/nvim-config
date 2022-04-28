local M = {}

-- configure toggleterm.nvim
function M.config()
    if not vim.o.hidden then
        print("toggleterm needs 'hidden' option, now hidden = true")
        vim.o.hidden = true
    end
    require("toggleterm").setup()
    M.term()
    M.lazygit()
end

-- setup toggleterminal
function M.term()
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({
        size = 15,
        hidden = true,
    })
    function _TOGGLE_TERM()
        term:toggle()
    end

    function _TOGGLE_TERM_VERTICAL()
        local is_open = term:is_open()
        if is_open then
            term:close()
        end
        term:open(vim.o.columns * 0.4, "vertical", false)
    end

    function _TOGGLE_TERM_HORIZONTAL()
        local is_open = term:is_open()
        if is_open then
            term:close()
        end
        term:open(15, "horizontal", false)
    end

    local whichkey = require("which-key")
    whichkey.register({
        ["<C-t>"] = {
            name = "ToggleTerm",
            ["<CR>"] = { "<cmd>lua _TOGGLE_TERM()<CR>", "Open Term" },
            ["<C-CR>"] = { "<cmd>lua _TOGGLE_TERM()<CR>", "Open Term" },
            v = { "<cmd>lua _TOGGLE_TERM_VERTICAL()<CR>", "Open Vertical Terminal" },
            s = { "<cmd>lua _TOGGLE_TERM_HORIZONTAL()<CR>", "Open Horizontal Terminal" },
        },
    })
    whichkey.register({
        ["<C-t>"] = {
            name = "ToggleTerm",
            ["<CR>"] = { "<cmd>lua _TOGGLE_TERM()<CR>", "Close Term" },
            ["<C-CR>"] = { "<cmd>lua _TOGGLE_TERM()<CR>", "Close Term" },
            v = { "<cmd>lua _TOGGLE_TERM_VERTICAL()<CR>", "Move Terminal Vertical" },
            s = { "<cmd>lua _TOGGLE_TERM_HORIZONTAL()<CR>", "Open Terminal Horizontal" },
        },
    }, { mode = "t" })
end

-- setup lazygit toggleterm
function M.lazygit()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
    })

    function _TOGGLE_LAZYGIT()
        lazygit:toggle()
    end

    local whichkey = require("which-key")
    whichkey.register({
        g = {
            name = "git",
            l = { "<cmd>lua _TOGGLE_LAZYGIT()<CR>", "Lazygit" },
        },
    }, { prefix = "<Leader>" })
    whichkey.register({
        ["<C-t>"] = {
            name = "Toggle Lazygit",
            g = { "<cmd>lua _TOGGLE_LAZYGIT()<CR>", "Lazygit" },
        },
    })
end

return M
