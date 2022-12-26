local M = {}

M.requires = { "nvim-treesitter/nvim-treesitter" }

function M.config()
    local ok, rainbow = pcall(require, "nvim-treesitter.configs")

    if not ok then
        vim.notify_once("plugin 'nvim-ts-rainbow' not found", vim.log.levels.WARN)
        return
    end

    rainbow.setup({
        rainbow = {
            enable = true,
            colors = {
                "#FFD700",
                "#87CEFA",
                "#DA70D6",
            },
        },
    })
end

M.lazy = {
    "p00f/nvim-ts-rainbow",
    requires = M.requires,
    config = M.config,
}

return { M.lazy }
