local M = {}

M.dependencies = { "mfussenegger/nvim-dap" }
M.ft = { "python" }

function M.config()
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        local venv_python = string.format("%s/bin/python", venv)
        require("dap-python").setup(venv_python)
    else
        require("dap-python").setup()
    end
end

M.lazy = {
    "mfussenegger/nvim-dap-python",
    dependencies = M.dependencies,
    ft = M.ft,
    config = M.config,
}

return M
