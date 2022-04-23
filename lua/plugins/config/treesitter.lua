local M = {}

M.run = ":TSUpdate"

M.setup = function()
    -- list of must installed languages
    -- local ensure_installed = {
    --     "rust",
    --     "toml",
    --     "fish",
    --     "cpp",
    --     "lua",
    -- }

    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "rust",
            "toml",
            "fish",
            "cpp",
            "lua",
        },
        highlight = { enable = true, }
    }
end

-- configure treesitter
-- call setup
M.config = function()
    M.setup()
end

return M
