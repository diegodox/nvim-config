---@type LazySpec
local M = { "mfussenegger/nvim-dap" }

M.dependencies = { "nvim-telescope/telescope.nvim" }

local function setup_rust()
    local dap = require("dap")
    dap.adapters.rust = {
        attach = { pidProperty = "pid", pidSelect = "ask" },
        command = "lldb-vscode", -- my binary was called 'lldb-vscode-11'
        env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
        name = "lldb",
        type = "executable",
    }
end

local function sign_define() vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" }) end

local function keymap()
    local dap = require("dap")
    require("plugins.which-key").pregister({ d = { name = "DAP" } }, { prefix = "<Leader>" })

    local set_breakpoint = function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end

    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<Leader>dn", dap.step_over, { desc = "DAP Step over" })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP Step into" })
    vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "DAP Step out" })
    vim.keymap.set("n", "<Leader>dR", dap.repl.open, { desc = "DAP Open REPL" })
    vim.keymap.set("n", "<Leader>dg", dap.run_last, { desc = "DAP run last" })
    vim.keymap.set("n", "<Leader>dq", dap.disconnect, { desc = "DAP disconnect debugger" })
    vim.keymap.set("n", "<Leader>dB", set_breakpoint, { desc = "DAP Breakpoint condition" })
end

function M.config()
    sign_define()
    keymap()
    -- local telescope = require("plugins.telescope.dap")
    -- telescope.load_extension()
    -- telescope.keymap.dap()
    setup_rust()
end

return M
