local M = {}

local function set_transparent()
    if not vim.g.transparent_bg then
        vim.notify("not apply transparent", vim.lsp.log_levels.TRACE)
        vim.cmd("colorscheme " .. vim.g.colors_name)
        return
    end
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

function M.enable_transparent()
    vim.g.transparent_bg = true
    vim.api.nvim_exec_autocmds("colorscheme", {})
    vim.notify("Enable background transparent", vim.log.levels.TRACE)
end

function M.disable_transparent()
    vim.g.transparent_bg = false
    vim.api.nvim_exec_autocmds("colorscheme", {})
    vim.notify("Disable background transparent", vim.log.levels.TRACE)
end

function M.toggle_transparent()
    vim.g.transparent_bg = not vim.g.transparent_bg
    vim.api.nvim_exec_autocmds("colorscheme", {})
    vim.notify("Toggle background transparent", vim.log.levels.TRACE)
end

-- create autocommand that automatically set background transparent after set colorscheme
function M.setup_transparent()
    local group = vim.api.nvim_create_augroup("Transparent", { clear = true })
    vim.api.nvim_create_autocmd("colorscheme", { callback = set_transparent, group = group, desc = "set transparent" })
    vim.api.nvim_create_user_command(
        "ToggleBackgroundTranprent",
        "lua require('rc.utils').toggle_transparent()",
        { desc = "Toggle Background Transparentecy" }
    )
    vim.api.nvim_create_user_command(
        "EnableBackgroundTranprent",
        "lua require('rc.utils').enable_transparent()",
        { desc = "Enable Background Transparentecy" }
    )
    vim.api.nvim_create_user_command(
        "DisableBackgroundTranprent",
        "lua require('rc.utils').disable_transparent()",
        { desc = "Disable Background Transparentecy" }
    )
end

return M
