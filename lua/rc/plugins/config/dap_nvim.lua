local M = {}

local L = {}

M.requires = { "mfussenegger/nvim-dap" }
M.after = { "nvim-dap" }

function L.define_sign() vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" }) end

function L.keymap()
    require("rc.plugins.config.which-key").pregister({ d = { name = "DAP" } }, { prefix = "<Leader>" })

    local dapui = require("dapui")
    local dap = require("dap")
    local vsc = require("dap.ext.vscode")

    local set_breakpoint = function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end

    vim.keymap.set(
        "n",
        "<Leader>dl",
        function() vsc.load_launchjs(".vsocode/launch.json") end,
        { desc = "DAP load vsocde launch.json" }
    )

    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<Leader>dn", dap.step_over, { desc = "DAP Step over" })
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP Step into" })
    vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "DAP Step out" })
    vim.keymap.set("n", "<Leader>dR", dap.repl.open, { desc = "DAP Open REPL" })
    vim.keymap.set("n", "<Leader>dg", dap.run_last, { desc = "DAP run last" })
    vim.keymap.set("n", "<Leader>dq", dap.disconnect, { desc = "disconnect debugger" })
    vim.keymap.set("n", "<Leader>dB", set_breakpoint, { desc = "DAP Breakpoint condition" })

    vim.keymap.set("n", "<Leader>do", dapui.open, { desc = "DAP UI open" })
    vim.keymap.set("n", "<Leader>dx", dapui.close, { desc = "DAP UI close" })
    vim.keymap.set("n", "<Leader>dt", dapui.toggle, { desc = "DAP UI toggle" })

    vim.keymap.set("n", "<Leader>dk", dapui.float_element, { desc = "DAP UI float element" })
    vim.keymap.set("v", "<Leader>dk", dapui.eval, { desc = "DAP UI eval selected" })
end

function L.set_dap_event_listener()
    local dap, dapui = require("dap"), require("dapui")
    ---@diagnostic disable-next-line: missing-parameter
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    ---@diagnostic disable-next-line: missing-parameter
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    ---@diagnostic disable-next-line: missing-parameter
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

function M.config()
    require("dapui").setup()
    L.set_dap_event_listener()
    L.keymap()
    L.define_sign()
end

M.lazy = {
    "rcarriga/nvim-dap-ui",
    dependencies = M.requires,
    after = M.after,
    config = M.config,
}

return M
