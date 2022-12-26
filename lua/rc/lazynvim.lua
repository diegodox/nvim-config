local M = {}

function M.install()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
    end

    vim.opt.runtimepath:prepend(lazypath)
end

function M.setup()
    M.install()

    local ok, lazy = pcall(require, "lazy")

    if not ok then
        print("Failed to load lazy.nvim")
        return
    end

    lazy.setup("plugins")
end

return M
