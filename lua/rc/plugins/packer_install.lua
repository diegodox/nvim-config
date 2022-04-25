local M = {}

local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

--
-- Automatically install packer.nvim
--
function M.install()
    -- add packer.nvim to the runtime path
    -- this prevent fail on docker
    vim.o.runtimepath = vim.o.runtimepath .. install_path
    -- install packer.nvim to intstall_path
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        print("packer.nvim installed to " .. install_path .. "\n")
    end
end

return M
