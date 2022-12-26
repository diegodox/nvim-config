local M = { "nvim-treesitter/nvim-treesitter" }

function M.update() require("nvim-treesitter.install").update({ with_sync = true })() end

-- list of must installed languages
local ensure_installed = {
    "rust",
    "toml",
    "fish",
    "cpp",
    "lua",
    "python",
}

-- configure treesitter
function M.config()
    M.update()
    require("nvim-treesitter.configs").setup({
        ensure_installed = ensure_installed,
        highlight = { enable = true },
    })
    require("plugins.treesitter.highligh_workaround").set_hi()
end

return M
