local M = {}

-- setup Comment.nvim
M.setup = function()
    require("Comment").setup()
end

-- configure Comment.nvim
-- call setup
M.config = function()
    M.setup()
end

return M
