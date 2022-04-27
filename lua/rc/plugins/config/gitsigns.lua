local M = {}

function M.config()
    local ok, gitsigns = pcall(require, "gitsigns")

    if not ok then
        print("plugin 'gitsigns.nvim' not found")
        return
    end

    gitsigns.setup({
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = { delay = 100 },
    })

    M.keymap()
end

-- apply keymap
function M.keymap()
    local ok, whichkey = pcall(require, "which-key")

    if ok then
        whichkey.register({
            g = {
                name = "git",
                h = { "<cmd>Gitsigns preview_hunk<CR>", "Hunk diff" },
                D = { "<cmd>Gitsigns toggle_deleted<CR>", "Toggle show deleted" },
                W = { "<cmd>Gitsigns toogle_word_diff<CR>", "Toogle word diff" },
            },
        }, { prefix = "<Leader>" })
    else
        print("plugin 'which-key.nvim' not found, register keymap through nvim api")
        vim.api.nvim_set_keymap("n", "<Leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { noremap = true, silent = true })
    end
end

return M
