return
        {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
                local treesitterOptionsToUse = require( "nvim-treesitter.configs")
                treesitterOptionsToUse.setup(
                        {
                        ensure_installed =
                                {
                                "bash",
                                "c",
                                "cmake",
                                "cpp",
                                "dockerfile",
                                "html",
                                "java",
                                "javascript",
                                "json",
                                "lua",
                                "make",
                                "python",
                                "ssh_config",
                                "vim",
                                "vimdoc",
                                "yaml",
                                -- Swift seems dependent upon node.js..?
                                -- "swift",
                                },
                        sync_install = false,
                        highlight = { enable = true },
                        indent = { enable = true },
                        }
                )
        end
        }
