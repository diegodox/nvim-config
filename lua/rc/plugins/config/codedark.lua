-- vim-code-dark cofnig
local M = {}

function M.apply()
    vim.cmd([[colorscheme codedark]])
    -- print("colorscheme applied")
end

function M.transparent()
    if vim.g.neovide then
        -- print("apply neovide transparent")
        vim.g.neovide_transparency = 0.9
        vim.cmd([[highlight StartifyPath guibg=none]])
        vim.cmd([[highlight WarningMsg guibg=none]])
        vim.cmd([[highlight Error guibg=none]])
    else
        -- print("apply term neovim transparent")
        vim.cmd([[highlight Normal ctermbg=none guibg=none]])
        vim.cmd([[highlight NonText ctermbg=none guibg=none]])
        vim.cmd([[highlight EndOfBuffer ctermbg=none guibg=none]])
        vim.cmd([[highlight VertSplit ctermbg=none guibg=none]])
        vim.cmd([[highlight SignColumn ctermbg=none guibg=none]])
        vim.cmd([[highlight SpecialKey ctermbg=none guibg=none]])
        vim.cmd([[highlight WarningMsg ctermbg=none guibg=none]])
        vim.cmd([[highlight Error ctermbg=none guibg=none]])
        vim.cmd([[highlight clear LineNr]])
        vim.cmd([[highlight LineNr ctermfg=none guifg=none]])
        vim.cmd([[highlight StartifyPath ctermbg=none guibg=none]])
    end
end

function M.config()
    M.apply()
    if vim.g.transparent then
        M.transparent()
    else
        -- print("not apply transparent")
    end
end

return M
