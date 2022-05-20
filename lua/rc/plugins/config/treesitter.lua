local M = {}

M.run = ":TSUpdate"

-- list of must installed languages
M.ensure_installed = {
    "rust",
    "toml",
    "fish",
    "cpp",
    "lua",
    "python",
}

-- setup treesitter
function M.setup()
    local ok, nvtsconf = pcall(require, "nvim-treesitter.configs")

    if not ok then
        vim.notify_once("module 'nvim-treesitter.configs' not found", vim.log.levels.ERROR)
        return
    end

    nvtsconf.setup({
        ensure_installed = M.ensure_installed,
        highlight = { enable = true },
    })
end

-- configure treesitter
function M.config()
    M.setup()
end

return M
