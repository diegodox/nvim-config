local M = {}

--- dynamic layout based on nvim window size
---@param threshold number
---@return string
function M.dynamic_layout_strategy(threshold)
    local ui = vim.api.nvim_list_uis()
    if not ui or not ui[1] or not ui[1]["width"] then
        return "vertical"
    end
    if ui[1]["width"] > threshold then
        return "horizontal"
    end
    return "vertical"
end

return M
