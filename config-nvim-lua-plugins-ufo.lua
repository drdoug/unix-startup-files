return
        {
        "kevinhwang91/nvim-ufo",
        dependencies =
                {
                "kevinhwang91/promise-async",
                "neovim/nvim-lspconfig",
                },
        config = function()
                require( "ufo").setup(
                        {
                        provider_selector = function( _, _, _)
                                return { "lsp", "indent" }
                        end,
                        preview =
                                {
                                win_config =
                                        {
                                        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                                        winhighlight = "Normal:FoldedPreview,FloatBorder:FoldedPreviewBorder",
                                        winblend = 0,
                                        },
                                mappings =
                                        {
                                        scrollU = "<C-u>",
                                        scrollD = "<C-d>",
                                        },
                                },
                        })
        end,
        }
