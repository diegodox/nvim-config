local M = {
    "simrat39/rust-tools.nvim",
}

M.dependencies = { "mattn/webapi-vim" }

---@param bufnr number
local function keymap(bufnr)
    local r = require("rust-tools")
    require("plugins.which-key").pregister(
        { r = { name = "Rust" } },
        { prefix = "<Leader>" },
        "Setup rust keymap without 'which-key' bufnr: " .. bufnr
    )
    vim.keymap.set("n", "K", r.hover_actions.hover_actions, { desc = "Hover Action", buffer = bufnr })
    vim.keymap.set({ "n", "v" }, "J", r.join_lines.join_lines, { desc = "Join line", buffer = bufnr })

    vim.keymap.set("n", "<Leader>rp", r.parent_module.parent_module, { desc = "Parent Module", buffer = bufnr })
    vim.keymap.set("n", "<Leader>rr", r.runnables.runnables, { desc = "Runnables", buffer = bufnr })
    vim.keymap.set("n", "<Leader>rc", r.open_cargo_toml.open_cargo_toml, { desc = "Open Cargo.toml", buffer = bufnr })
end

function M.config()
    local server = require("plugins.lsp_config").server_opts("rust_analyzer", {
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
    })

    -- wrap server.on_attach
    local on_attach = server.on_attach
    server.on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        keymap(bufnr)
    end

    local cfg = {
        server = server,
        tools = {
            inlay_hints = { highlight = "NonText" },
            hover_actions = {
                max_width = 80,
                max_height = 30,
            },
        },
    }

    require("rust-tools").setup(cfg)
end

return M
