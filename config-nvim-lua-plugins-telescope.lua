return
        {
        {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies =
                {
                'nvim-lua/plenary.nvim',
                "nvim-telescope/telescope-file-browser.nvim",
                'BurntSushi/ripgrep'
                },
        config = function()
        end
        },
        {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
                require("telescope").setup(
                        {
                        extensions =
                                {
                                ["ui-select"] =
                                        {
                                        require( "telescope.themes").get_dropdown(
                                                {
                                                })
                                        }
                                }
                        })
                require( "telescope").load_extension( "file_browser")
                require( "telescope").load_extension( "ui-select")
        end
        },
        }
