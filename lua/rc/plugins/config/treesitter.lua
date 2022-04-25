local M = {}

M.run = ":TSUpdate"

-- list of must installed languages
M.ensure_installed = {
    "rust",
    "toml",
    "fish",
    "cpp",
    "lua",
}

-- setup treesitter
function M.setup()
    local ok, nvtsconf = pcall(require, "nvim-treesitter.configs")

    if not ok then
        print("module 'nvim-treesitter.configs' not found")
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
