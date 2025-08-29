return
        {
                {
                "williamboman/mason.nvim",
                config = function()
                        require( "mason").setup()
                end
                },
                {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require( "mason-lspconfig").setup(
                                {
                                ensure_installed =
                                        {
                                        "bashls",       -- bash
                                        "clangd",       -- C, C++
                                        "cmake",        -- Cmake
                                        "lua_ls",       -- LUA
                                        "marksman",     -- Markdown
                                        "pyright",      -- Python
                                        "vimls",        -- VimScript
                                        },
                                })
                end
                },
                {
                "neovim/nvim-lspconfig",
                config = function()
                        local lspconfig = require( "lspconfig")
                        lspconfig.bashls.setup(
                                {
                                {
                                bashIde = { globPattern = "*@(.sh|.bash|.ksh|.zsh)" },
                                }
                                })
                        lspconfig.clangd.setup(
                                {
                                filetypes = { "c", "cc", "cpp", },
                                cmd = { "/usr/bin/clangd" },
                                })
                        lspconfig.cmake.setup( {})
                        lspconfig.lua_ls.setup( {})
                        lspconfig.marksman.setup( {})
                        lspconfig.pyright.setup( {})
                        lspconfig.vimls.setup( {})
                        vim.api.nvim_create_autocmd( "LspAttach",
                                {
                                callback = function( args)
                                        local client = vim.lsp.get_client_by_id( args.data.client_id)
                                        if client and client.server_capabilities.foldingRangeProvider
                                        then
                                                vim.wo.foldmethod = "expr"
                                                vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
                                        end
                                end,
                                })
                end,
                },
        }
