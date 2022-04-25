-- config moudle for null-ls
local M = {}

-- required plugins to run null-ls
M.requires = "nvim-lua/plenary.nvim"

-- configure null-ls
function M.config()
	local ok, null_ls = pcall(require, "null-ls")
	if not ok then
		print("plugin 'null-ls' not found")
	end
	null_ls.setup({
		sources = {
		},
		on_attach = function(client)
		end,
	})
end

return M
