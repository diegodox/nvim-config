local M = {}

M.requires = { "mattn/webapi-vim" }

function M.setup()
    local cfg = {
        tools = { inlay_hints = { highlight = "NonText" } },
        server = require("rc.plugins.config.lsp_config").server_opts("rust_analyzer", {
            -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            settings = {
                -- To enable rust-analyzer settings, visit: https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                -- Sometimes this is better resource: https://github.com/simrat39/rust-tools.nvim/wiki/Server-Configuration-Schema
                ["rust-analyzer"] = {
                    cargo = { allFeatures = true },
                    checkOnSave = {
                        command = "clippy",
                        extraArgs = { "--examples", "--tests", "--benches" },
                        allFeatures = true,
                    },
                },
            },
        }),
    }
    require("rust-tools").setup(cfg)
end

return M
