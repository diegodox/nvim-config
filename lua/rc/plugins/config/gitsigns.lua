local M = {}

function M.config()
    local ok, gitsigns = pcall(require, "gitsigns")

    if not ok then
        vim.notify_once("plugin 'gitsigns.nvim' not found", vim.log.levels.INFO)
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
        whichkey.register({ g = { name = "git" } }, { prefix = "<Leader>" })
    else
        vim.notify_once("Plugin 'which-key' not found\nSetup keymap without 'which-key'", vim.lsp.log_levels.WARN)
    end

    vim.keymap.set("n", "<Leader>gh", "<cmd>Gitsigns preview_hunk<CR>", { silent = true, desc = "Preview Hunk Diff" })
end

return M
