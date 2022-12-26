local M = {
    module = true,
}

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

--- Call `git_files` if in git directory, otherwise call `find_files`.
--- Smarter than my old config.
function M.smart_find_file()
    local builtin = require("telescope.builtin")
    local threshold = 170
    vim.fn.system("git rev-parse")
    if vim.v.shell_error == 0 then
        builtin.git_files({
            layout_strategy = M.dynamic_layout_strategy(threshold),
            show_untracked = true,
        })
    else
        local telescope = package.loaded.telescope
        telescope.extensions.frecency.frecency({
            layout_strategy = M.dynamic_layout_strategy(threshold),
        })
    end
end

return M
