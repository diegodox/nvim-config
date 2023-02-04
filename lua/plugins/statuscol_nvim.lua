---@type LazySpec
local M = { "luukvbaal/statuscol.nvim" }
M.lazy = true
-- F: fold(ScFA)
-- S: sign(ScSa)
-- N: number(ScLa)
-- s: separator?(ScSp)
function M.config()
    require("statuscol").setup({ setopt = true, order = "SNF", foldfunc = "builtin" })
end

return M
