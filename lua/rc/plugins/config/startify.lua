local M = {}

function M.setup()
    vim.g.startify_session_persistence = 1
    vim.g.startify_custom_header = {}
    vim.g.startify_lists = {
        { type = 'sessions',  header = { '   Sessions' } },
        { type = 'files',     header = { '        MRU' } },
        { type = 'dir',       header = { '        MRU @ ' .. vim.fn.getcwd() } },
        { type = 'bookmarks', header = { '  Bookmarks' } },
        { type = 'commands',  header = { '   Commands' } },
    }
end

return M
