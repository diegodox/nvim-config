local M = { "glepnir/lspsaga.nvim", branch = "main" }

function M.config()
    require("lspsaga").init_lsp_saga({
        saga_winblend = 10,
        max_preview_lines = 30,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LspSaga Highlight MirrorBuiltin", { clear = true }),
        callback = function()
            vim.cmd.highlight("link", "FloatBorder", "LspSagaHoverBorder")
            vim.cmd.highlight("link", "NormalFloat", "Normal")
        end,
        desc = "link from lspsaga highlight to builtin highlight",
    })
end

---@param name string
---@param ... unknown
local function command(name, ...)
    local saga_command = require("lspsaga.command")
    local args = ...
    saga_command.load_command(name, args)
end

local function hover_doc() command("hover_doc") end
local function code_action() command("code_action") end
local function peek_definition() command("peek_definition") end
local function lsp_finder() command("lsp_finder") end

---@param bufnr number
function M.keymap(bufnr)
    require("plugins.which-key").pregister(
        { l = { name = "LSP" } },
        { prefix = "<Leader>" },
        "Setup LSP keymap without 'which-key' bufnr: " .. bufnr
    )
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format", buffer = bufnr })

    -- lsp saga

    vim.keymap.set("n", "K", hover_doc, { desc = "Hover", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lh", hover_doc, { desc = "Hover", buffer = bufnr })
    -- vim.keymap.set("n", "<Leader>l.", code_action, { desc = "Code Action", buffer = bufnr })
    vim.keymap.set("n", "<Leader>ld", peek_definition, { desc = "Peek Definitions", buffer = bufnr })
    vim.keymap.set("n", "<Leader>lD", lsp_finder, { desc = "Declaration", buffer = bufnr })

    -- vim.keymap.set("n", "gd", lsp_finder, { desc = "Lsp Finder", buffer = bufnr })

    -- rename
    local increname = require("plugins.increname").increname
    vim.keymap.set("n", "<F2>", increname, { desc = "Rename", buffer = bufnr, expr = true })
end

return M
