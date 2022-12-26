local M = {}

M.requires = { "nvim-treesitter/nvim-treesitter" }

function M.config()
    local select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = false,

        keymaps = {
            aP = { query = "@parameter.outer", desc = "a Parameter" },
            iP = { query = "@parameter.inner", desc = "a Parameter" },

            aF = { query = "@function.outer", desc = "a Function" },
            iF = { query = "@function.inner", desc = "a Function body" },

            ["af"] = { query = "@call.outer", desc = "a Function Call" },
            ["if"] = { query = "@call.inner", desc = "a Function Call body" },

            aC = { query = "@class.outer", desc = "a Class" },
            iC = { query = "@class.inner", desc = "a Class body" },
        },

        -- You can choose the select mode (default is charwise 'v')
        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
        },

        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding xor succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        include_surrounding_whitespace = true,
    }

    local swap = {
        enable = true,

        swap_next = {
            ["<leader>a"] = { query = "@parameter.inner", desc = "Swap parameter with next" },
        },

        swap_previous = {
            ["<leader>A"] = { query = "@parameter.inner", desc = "Swap parameter with previous" },
        },
    }

    local move = {
        enable = true,

        set_jumps = true, -- whether to set jumps in the jumplist

        goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Jump to next fucntion start" },
            ["]]"] = { query = "@class.outer", desc = "Jump to next class start" },
        },

        goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Jump to next fucntion end" },
            ["]["] = { query = "@class.outer", desc = "Jump to next class end" },
        },

        goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Jump to previous function start" },
            ["[["] = { query = "@class.outer", desc = "Jump to previous class satrt" },
        },

        goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Jump to previous function end" },
            ["[]"] = { query = "@class.outer", desc = "Jump to previous class end" },
        },
    }

    require("nvim-treesitter.configs").setup({
        textobjects = {
            select = select,
            swap = swap,
            move = move,
        },
    })
end

M.lazy = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = M.requires,
    config = M.config,
}

return { M.lazy }
