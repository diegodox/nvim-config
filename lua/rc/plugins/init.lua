require("rc.plugins.lazynvim").install()

local ok, lazy = pcall(require, "lazy")

if not ok then
    print("Failed to load lazy.nvim")
    return
end

local plugins = require("rc.plugins.plugins")
lazy.setup(plugins, {})
