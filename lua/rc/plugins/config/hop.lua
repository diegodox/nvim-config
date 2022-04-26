-- hop.nvim configuration
local hop_config = {}

function hop_config.setup() end

function hop_config.keymap()
    require("which-key").register({ f = { "<Cmd>HopChar1<CR>", "Hop to char" } }, { prefix = "<Leader>" })
    vim.api.nvim_set_keymap(
        "n",
        "f",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>",
        {}
    )
    vim.api.nvim_set_keymap(
        "n",
        "F",
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>",
        {}
    )
end

function hop_config.config()
    require("hop").setup()
    hop_config.keymap()
end

return hop_config
