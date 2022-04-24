local M = {}

M.requires = {
    -- snip engine
    "L3MON4D3/LuaSnip",
    -- sources
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline"
}

-- call cmp.setup
function M.setup(cmp)
    local luasnip = require('luasnip')
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }),

        preselect = true,
        mapping = {
            ['<C-Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ['<C-Down>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

            ['<Up>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { "i", "c" }),
            ['<Down>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { "i", "c" }),

            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),

            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false
            }),

            ['<Tab>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.confirm({select = false})
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
        },

        experimental = {
            ghost_text = true,
        }
    })
end

function M.setup_search(cmp)
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
end

function M.setup_cmdline(cmp)
    cmp.setup.cmdline(':', {
        mapping = {
            ['<Tab>'] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.confirm({select = false})
                    else
                        fallback()
                    end
                end, { "c" }
            ),
        },
        sources = {
            { name = "cmdline" },
            { name = "path" },
        },
    })
end

M.set_hightlight = function()
    vim.cmd[[highlight CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
    vim.cmd[[highlight CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
    vim.cmd[[highlight CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
    vim.cmd[[highlight CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
    vim.cmd[[highlight CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
    vim.cmd[[highlight CmpItemKindText guibg=NONE guifg=#9CDCFE]]
    vim.cmd[[highlight CmpItemKindFunction guibg=NONE guifg=#C586C0]]
    vim.cmd[[highlight CmpItemKindMethod guibg=NONE guifg=#C586C0]]
    vim.cmd[[highlight CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
    vim.cmd[[highlight CmpItemKindProperty guibg=NONE guifg=#D4D4D4]]
    vim.cmd[[highlight CmpItemKindUnit guibg=NONE guifg=#D4D4D4]]
end

-- setup, setup_cmdline, setup_search, set_hightlight
function M.config()
    local ok, cmp = pcall(require, 'cmp')
    if not ok then
        print("plugin 'cmp' not found")
        return
    end
    M.setup(cmp)
    M.setup_cmdline(cmp)
    M.setup_search(cmp)
    M.set_hightlight()
end

return M
