local M = {}

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

-- setup treesitter
function M.setup()
    local ok, nvtsconf = pcall(require, "nvim-treesitter.configs")

    if not ok then
        vim.notify_once("module 'nvim-treesitter.configs' not found", vim.log.levels.ERROR)
        return
    end

    nvtsconf.setup({
        ensure_installed = ensure_installed,
        highlight = { enable = true },
    })
end

-- configure treesitter
function M.config() M.setup() end

M.lazy = {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        M.update()
        M.config()
        require("rc.plugins.config.treesitter.highligh_workaround").set_hi()
    end,
}

--return { M.lazy }
