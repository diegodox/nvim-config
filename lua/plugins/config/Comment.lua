local M = {}

-- setup Comment.nvim
function M.setup()
    require("Comment").setup()
end

-- configure Comment.nvim
-- call setup
function M.config()
    M.setup()
end

return M
