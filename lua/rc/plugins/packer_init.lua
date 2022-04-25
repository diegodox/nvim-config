local M = {}

function M.init(packer)
    --
    -- Have packer.nvim popup
    --
    packer.init({
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    })
end

return M
