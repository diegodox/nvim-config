---@type LazySpec
local M = {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "Colorscheme" },
}

M.dependencies = { "nvim-lua/plenary.nvim" }

function keymap(bufnr)
    require("plugins.which-key").pregister({ g = { name = "Git" } }, { prefix = "<Leader>" })

    local gs = require("gitsigns")
    local function next_hunk()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
    end

    local function prev_hunk()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
    end

    vim.keymap.set("n", "]c", next_hunk, { desc = "Previous Git Hunk", buffer = bufnr })
    vim.keymap.set("n", "[c", prev_hunk, { desc = "Next Git Hunk", buffer = bufnr })

    vim.keymap.set("n", "<Leader>gh", gs.preview_hunk, { desc = "Preview Hunk Diff", buffer = bufnr })
    vim.keymap.set("n", "<Leader>gs", gs.stage_hunk, { desc = "Stage Hunk", buffer = bufnr })
    vim.keymap.set("n", "<Leader>gR", gs.reset_hunk, { desc = "Reset Hunk", buffer = bufnr })
    vim.keymap.set("n", "<Leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk", buffer = bufnr })
    vim.keymap.set("n", "<leader>gb", gs.blame_line, { desc = "Blame current line", buffer = bufnr })
    vim.keymap.set("n", "<Leader>gd", gs.toggle_deleted, { desc = "Toggle deleted", buffer = bufnr })
    vim.keymap.set(
        "n",
        "<Leader>gB",
        gs.toggle_current_line_blame,
        { desc = "Toggle current line git blame", buffer = bufnr }
    )
    -- git hunk as text object
    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk", buffer = bufnr })
end

-- local signs = {
--     add = { numhl = "GitSignsAddLn" },
--     change = { numhl = "GitSignsChangeLn" },
--     delete = { numhl = "GitSignsDeleteLn" },
-- }

function M.config()
    require("gitsigns").setup({
        signs = signs,
        numhl = true,
        signcolumn = false,
        current_line_blame = false,
        current_line_blame_opts = { delay = 100 },
        sign_priority = 100,
        on_attach = keymap,
    })
end

return M
