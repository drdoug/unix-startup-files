return
        {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
                local treesitterOptions = require( "nvim-treesitter.configs")
                treesitterOptions.setup(
                        {
                        sync_install = false,
                        auto_install = true,
                        highlight =
                                {
                                enable = true,
                                disable =
                                        {
                                        "c",
                                        "cpp",
                                        },
                                },
                        indent =
                                {
                                enable = false,
                                },
                        fold =
                                {
                                enable = true,
                                },
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
                                "markdown",
                                "python",
                                "ssh_config",
                                "vim",
                                "vimdoc",
                                "yaml",
                                },
                        textobjects =
                                {
                                move =
                                        {
                                        enable = true,
                                        set_jumps = true,
                                        goto_next_start =
                                                {
                                                [']m'] = '@function.outer',
                                                },
                                        goto_previous_start =
                                                {
                                                ['[m'] = '@function.outer',
                                                },
                                        },
                                }

                        }
                )
        end
        }
