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
--                              Leave this for now...
--                                on_attach = function( client, bufnr)
--                                        client.server_capabilities.signatureHelpProvider = false
--                                        on_attach( client, bufnr)
--                                end,
--                                capabilities = capabilities
                                })
                        lspconfig.cmake.setup( {})
                        lspconfig.lua_ls.setup( {})
                        lspconfig.marksman.setup( {})
                        lspconfig.pyright.setup( {})
                        lspconfig.vimls.setup( {})
                end
                },
        }
