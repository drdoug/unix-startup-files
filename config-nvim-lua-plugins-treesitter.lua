return
        {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
                local treesitterOptionsToUse = require( "nvim-treesitter.configs")
                -- treesitterOptionsToUse.setup(
                treesitterOptionsToUse.setup(
                        {
                        -- sync_install = false,
                        auto_install = true,
                        highlight = { enable = true },
                        indent = { enable = true },
                        ensure_installed =
                                {
                                -- "bash",
                                "c",
                                -- "cmake",
                                "cpp",
                                -- "dockerfile",
                                -- "html",
                                -- "java",
                                -- "javascript",
                                -- "json",
                                "lua",
                                "make",
                                -- "python",
                                -- "ssh_config",
                                "vim",
                                "vimdoc",
                                -- "yaml",
                                -- Swift seems dependent upon node.js..?
                                -- "swift",
                                },
                        }
                )
        end
        }
