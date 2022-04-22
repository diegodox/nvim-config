local fn = vim.fn

--
-- Automatically install packer.nvim
--
local install_path = fn.stdpath("data")..'/site/pack/packer/start/packer.nvim'
-- add packer.nvim to the runtime path
-- this prevent fail on docker
vim.o.runtimepath = vim.o.runtimepath..install_path
-- install packer.nvim to intstall_path
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
         "git",
         "clone",
         "--depth",
         "1",
         "https://github.com/wbthomason/packer.nvim",
         install_path
    })
    print("packer.nvim installed to "..install_path..'\n')
end

--
-- Prevent fail on error require("packer")
--
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    print("Failed to load packer.nvim")
    return
end

--
-- Have packer.nvim popup
--
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = 'rounded' }
        end
    }
}

--
-- Install plugins
--
return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "tomasiser/vim-code-dark",
        config = function()
            vim.cmd [[colorscheme codedark]]
        end
    }
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
            vim.g.timeoutlen = 100
        end
    }
    use {
        "lewis6991/gitsigns.nvim",
        event = "VimEnter",
        requires = "nvim-lua/plenary.nvim",
        after = { "which-key.nvim" } ,
        config = function()
            vim.cmd [[ echo "loading gitsigns" ]]
            require("gitsigns").setup {
                current_line_blame = true,
                current_line_blame_opts = { delay = 100 },
            }
        end
    }
    use {
        "numToStr/Comment.nvim",
        event = "VimEnter",
        config = function()
            require("Comment").setup()
        end
    }

    use {
        "kdheepak/lazygit.nvim",
        config = function()
            -- if vim.fn.excutable("nvr") then
            --     vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +"set bufhidden=wipe""
            -- end
            vim.api.nvim_set_keymap(
                "n",
                "<C-g>",
                ":LazyGit<CR>",
                {noremap=true, silent=true}
            )
        end
    }
    use {
        "kevinhwang91/rnvimr",
        after = "which-key.nvim",
        config = function()
            require("which-key").register(
                { b = { "<Cmd>RnvimrToggle<CR><Cmd>RnvimrResize 2<CR>", "Open ranger file manager" } },
                { prefix = "<Leader>" }
            )
            vim.g.rnvimr_enable_ex = 1
            vim.g.rnvimr_enable_picker = 1
            vim.g.rnvimr_enable_bw = 1
        end
    }

    use {
        "nvim-lualine/lualine.nvim",
        after = colorscheme,
        config = function()
            require("lualine").setup()
        end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        event = "VimEnter",
        config = function()
            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
            vim.g.indent_blankline_show_trailing_blankline_indent=false

            require("indent_blankline").setup {
                filetype_exclude = {
                    "help",
                    "startify",
                    "Term",
                    "packer",
                    "nvim-lsp-installer"
                },
                space_char_blankline = " ",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                },
            }
        end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        event = "VimEnter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = {"rust", 'toml', 'fish', 'cpp', 'lua'},
                highlight = {
                    enable = true,
                }
            }
        end
    }
    use {
        "p00f/nvim-ts-rainbow",
        after = { "nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup {
                rainbow = {
                    colors = {
                        "#FFD700",
                        "#87CEFA",
                        "#DA70D6",
                    },
                }
            }
        end
    }

    -- telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case"
                    },
                    layout_strategy = "horizontal",
                    layout_defaults = {
                        horizontal = {
                            mirror = false,
                            preview_width = 0.5
                        },
                        vertical = {
                            mirror = false
                        }
                    },
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                            ["<esc>"] = actions.close,
                        },
                        -- n = {
                        --     ["<C-h>"] = "which_key",
                        -- }
                    },
                },
                pickers = {
                    find_files = {
                        prompt_prefix = "🔍",
                    },
                    buffers = {
                        mappings = {
                            i = {
                                ["<C-z>"] = "delete_buffer"
                            }
                        },
                    }
                }
            }
            vim.api.nvim_set_keymap(
                "n",
                "<C-p>",
                "<Cmd>lua require('telescope.builtin').find_files()<cr>",
                {noremap = true, silent = true}
            )
            vim.api.nvim_set_keymap(
                "n",
                "<M-p>",
                "<Cmd>lua require('telescope.builtin').buffers()<CR>",
                {noremap = true, silent = true}
            )
        end
    }
    use({
		"nvim-telescope/telescope-packer.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension('packer')
		end,
	})
    use {
        -- "LinArcX/telescope-command-palette.nvim",
        "diegodox/telescope-command-palette.nvim",
        branch = "fix-remove-category",
        after = { "telescope.nvim", "which-key.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    command_palette = {
                        { "Select entire file", ":call feedkeys('GVgg')" },
                        { "Save file", ":w" },
                        { "Save all files", ":wa" },
                        { "Close window", ":q" },
                        { "Force close window", ":q!" },
                        { "Quit vim", ":qa" },
                        { "Force Quit vim", ":qa!" },
                        { "Live Grep 🔭", ":lua require('telescope.builtin').live_grep()", 1 },
                        { "Git Files 🔭", ":lua require('telescope.builtin').git_files()", 1 },
                        { "Fuuzy-find File 🔭", ":lua require('telescope.builtin').find_files()", 1 },
                        { "Go to match bracket", "%" },
                        { "Go to open outside bracket", "[(" },
                        { "Go to close outside bracket", "])" },
                    }
                }
            })
            require("telescope").load_extension('command_palette')
            require("which-key").register(
                { [";"] = { "<Cmd>Telescope command_palette<CR>", "Command Palette" } },
                { prefix = "<Leader>" }
            )
            -- vim.api.nvim_set_keymap(
            --     "n",
            --     "<Leader>;",
            --     "<Cmd>Telescope command_palette<CR>",
            --     {noremap = true, silent = true}
            -- )
        end
    }
    use {
        "xiyaowong/telescope-emoji.nvim",
        after = { "telescope.nvim" },
        config = function()
            require("telescope").load_extension("emoji")
        end
    }

    --
    -- LSP
    --
    use {
        "neovim/nvim-lspconfig",
        -- after = "cmp-nvim-lsp",
        config = function()
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end
    }
    use {
        "williamboman/nvim-lsp-installer",
        after = { "nvim-lspconfig" },
        config = function()
            local lsp_installer = require("nvim-lsp-installer")

            local servers = {
                "rust_analyzer",
                "sumneko_lua",
                "clangd",
            }

            lsp_installer.on_server_ready(function(server)
                local opts = {}
                server:setup(opts)
                vim.cmd([[do User LspAttachBuffers]])
            end)

            for _, name in pairs(servers) do
                local is_server_found, server = lsp_installer.get_server(name)
                if not is_server_found then
                    print("LSP: " .. name .. " is not found")
                elseif server:is_installed() then
                    -- print("LSP: " .. name .. " is already installed")
                else
                    -- print("Installing LSP: " .. name)
                    server:install()
                end
            end
        end
    }

    -- Automatic setup plugins
    if packer_bootstrap then
          require("packer").sync()
    end

end)

