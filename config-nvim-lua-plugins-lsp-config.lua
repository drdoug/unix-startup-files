return
        {
                {
                "williamboman/mason.nvim",
                config = function()
                        require( "mason").setup()
                end,
                },
                {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                        require( "mason-lspconfig").setup(
                                {
                                ensure_installed =
                                        {
                                        "bashls",   -- bash
                                        "clangd",   -- C, C++
                                        "cmake",    -- CMake
                                        "lua_ls",   -- Lua
                                        "marksman", -- Markdown
                                        "pyright",  -- Python
                                        "vimls",    -- VimScript
                                        },
                                -- We’ll use handlers to call vim.lsp.enable for installed servers
                                handlers =
                                        {
                                        -- default handler: just enable the server using default config
                                        function( server_name)
                                                vim.lsp.enable( server_name)
                                        end,
                                        -- you can override per-server if needed
                                        bashls = function()
                                                vim.lsp.config( "bashls",
                                                        {
                                                        settings =
                                                                {
                                                                bashIde =
                                                                        {
                                                                        globPattern = "*@(.sh|.bash|.ksh|.zsh)",
                                                                        },
                                                                },
                                                        })
                                                vim.lsp.enable( "bashls")
                                        end,
                                        clangd = function()
                                                vim.lsp.config("clangd",
                                                        {
                                                        filetypes = { "c", "cc", "cpp" },
                                                        cmd = { "/usr/bin/clangd" },
                                                        })
                                                vim.lsp.enable("clangd")
                                        end,
                                        cmake = function()
                                                vim.lsp.config("cmake", {})
                                                vim.lsp.enable("cmake")
                                        end,
                                        lua_ls = function()
                                                vim.lsp.config("lua_ls", {})
                                                vim.lsp.enable("lua_ls")
                                        end,
                                        marksman = function()
                                                vim.lsp.config("marksman", {})
                                                vim.lsp.enable("marksman")
                                        end,
                                        pyright = function()
                                                vim.lsp.config("pyright", {})
                                                vim.lsp.enable("pyright")
                                        end,
                                        vimls = function()
                                                vim.lsp.config("vimls", {})
                                                vim.lsp.enable("vimls")
                                        end,
                                        },
                                })
                        end,
                },
                {
                "neovim/nvim-lspconfig",
                config = function()
                        local function on_attach( client, bufnr)
                        local opts = { buffer = bufnr }
                end

                -- Optionally define default config for *all* servers
                vim.lsp.config( "*",
                        {
                        on_attach = on_attach,
                        -- You can also set default capabilities here if needed.
                        -- But note: with the new API, capabilities are merged/extended automatically:
                        --     [oai_citation:0‡Reddit](https://www.reddit.com/r/neovim/comments/1knwtis/the_new_lsp_api/?utm_source=chatgpt.com)
                        })

                -- Autocmd to set folding if supported
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
