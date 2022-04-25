local M = {}

M.after = "nvim-treesitter"

function M.config()
    local ok, conf = pcall(require, "nvim-treesitter.configs")

    if not ok then
        print("plugin 'nvim-ts-rainbow' not found")
        return
    end

    conf.setup({
        rainbow = {
            colors = {
                "#FFD700",
                "#87CEFA",
                "#DA70D6",
            },
        },
    })
end

return M
