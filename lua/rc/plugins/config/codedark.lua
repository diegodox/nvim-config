-- vim-code-dark cofnig
local M = {}

local function transparent()
    if vim.g.neovide then
        vim.notify("apply neovide transparent", vim.lsp.log_levels.TRACE)
        vim.g.neovide_transparency = 0.9
        vim.cmd([[highlight StartifyPath guibg=none]])
        vim.cmd([[highlight WarningMsg guibg=none]])
        vim.cmd([[highlight Error guibg=none]])
    else
        vim.notify("apply term neovim transparent", vim.lsp.log_levels.TRACE)
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

-- create autocommand group that automatticaly set transparent after set colorscheme
function M.autocmd()
    if vim.g.transparent then
        local group = vim.api.nvim_create_augroup("Transparent", { clear = true })
        vim.api.nvim_create_autocmd("colorscheme", { callback = transparent, group = group })
    end
end

return M
