vim.opt.relativenumber=1
vim.api.nvim_create_autocmd( "InsertEnter",     { command = [[set relativenumber]] })
vim.api.nvim_create_autocmd( "InsertLeave",     { command = [[set norelativenumber]] })
vim.api.nvim_create_autocmd( "FileType",        {
                                                desc = 'Makefiles require actual Tab characters',
                                                callback = function( event)
                                                        if event.match == 'make'
                                                                then
                                                                        vim.opt_local.expandtab = false
                                                                end
                                                        end,
                                                })
