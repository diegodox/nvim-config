local M = {}

-- if vim.fn.excutable("nvr") then
--     vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +"set bufhidden=wipe""
-- end

function M.keymap()
    vim.api.nvim_set_keymap(
        "n",
        "<C-g>",
        ":LazyGit<CR>",
        {noremap=true, silent=true}
    )
end

return M
