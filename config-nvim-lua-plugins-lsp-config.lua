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
                                        "ast_grep",             -- C#, C++, C, CSS, Dart, GO, HTML, Java
                                                                -- JavaScript, JSX, Kotlin, LUA, Python,
                                                                -- Rust, Typescript
                                        "bashls",               -- bash
                                        "clangd",               -- C, C++
                                        "harper_ls",            -- C, C++, C#, GO, JavaScript, LUA, Markdown,
                                                                -- Python, Ruby, Rust, TOML, Typescript
                                        "cmake",                -- Cmake
                                        "lua_ls",               -- LUA
                                        "marksman",             -- Markdown
                                        "pyright",              -- Python
                                        "vimls",                -- VimScript
                                        },
                                })
                end
                },
                {
                "neovim/nvim-lspconfig",
                config = function()
                        local lspconfig = require( "lspconfig")
                        lspconfig.lua_ls.setup( {})
                        lspconfig.ts_ls.setup( {})
                        lspconfig.clangd.setup(
                                {
--                      Leave this for now...
--                                on_attach = function( client, bufnr)
--                                        client.server_capabilities.signatureHelpProvider = false
--                                        on_attach( client, bufnr)
--                                end,
--                                capabilities = capabilities
                                })

                        vim.keymap.set( 'n',         'K',          vim.lsp.buf.hover,       {})
                        vim.keymap.set( 'n',         '<leader>gd', vim.lsp.buf.definition,  {})
                        vim.keymap.set( { 'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
                end
                },
        }
