return
        {
        'nvim-lualine/lualine.nvim',
        dependencies =
                {
                'nvim-tree/nvim-web-devicons'
                },

        config = function()

                local function bufferSearchStatus()
                        local last_search = vim.fn.getreg( '/')
                        if not last_search or last_search == '' then
                                return ''
                        end
                        local searchcount = vim.fn.searchcount { maxcount = 9999 }
                        return 'Search: ' .. last_search .. ' (' .. searchcount.current .. ' of ' .. searchcount.total .. ')'
                end

                local function bufferChanged()
                        if vim.bo.modified then
                                return '●'
                        end
                        return ''
                end
                local function bufferReadonly()
                        if vim.bo.modifiable == false or vim.bo.readonly == true then
                                return ''
                        end
                        return ''
                end

                local function bufferLocation()
                        return ' Line %l of %L '
                end

                local function bufferNumber()
                        return 'buf %n'
                        -- return '%= buf %n'
                end

                local function bufferSpotAndColumn()
                        return 'Cursor=0x%B [Column %c%V]'
                end

                local colors =
                        {
                        Black           = '#000000',
                        DarkBlue        = '#4646BA',
                        MediumBlue      = '#4010B6',
                        LightBlue       = '#9898F4',
                        DarkGrey        = '#2A2A2A',
                        DarkRed         = '#881038',
                        LightGreen      = '#207736',
                        grey            = '#626262',
                        indigo          = '#4F27EE',
                        orange          = '#DC6009',
                        salmon          = '#DA8072',
                        yellow          = '#FFFF00',
                        red             = '#ca1243',
                        White           = '#f3f3f3',
                        Goldenrod       = '#DAA52F',
                        }

                local auroraTheme =
                        {
                        normal =
                                {
                                a = { fg = colors.Black, bg = colors.LightBlue },
                                b = { fg = colors.White, bg = colors.MediumBlue },
                                c = { fg = colors.White, bg = colors.DarkBlue },
                                x = { fg = colors.White, bg = colors.DarkBlue },
                                y = { fg = colors.White, bg = colors.MediumBlue },
                                z = { fg = colors.Black, bg = colors.LightBlue },
                                },
                        insert =
                                {
                                a = { fg = colors.White, bg = colors.DarkRed},
                                },
                        visual =
                                {
                                a = { fg = colors.White, bg = colors.salmon },
                                },
                        replace =
                                {
                                a = { fg = colors.White, bg = colors.DarkBlue },
                                },
                        command =
                                {
                                a = { fg = colors.Black, bg = colors.Goldenrod },
                                },
                        }

                require( 'lualine').setup
                        {
                        options =
                                {
                                theme = auroraTheme,
                                -- component_separators = '',
                                component_separators =
                                        {
                                        left = '',
                                        right = ''
                                        -- left = '',
                                        -- right = ''
                                        },
                                section_separators =
                                        {
                                        left = '',
                                        right = ''
                                        },
                                },
                        sections =
                                {
                                lualine_a =
                                        {
                                        {
                                        'mode',
                                        icons_enabled = true,
                                        separator = { right = '' },
                                        right_padding = 2,
                                        fmt = function( str)
                                                return str:sub( 1,9)
                                        end
                                        }
                                        },
                                lualine_b =
                                        {
                                        { 'filename', file_status = false, path = 0 },
                                        { bufferChanged, color = { fg = colors.red } },
                                        { bufferReadonly, color = { fg = colors.orange } },
                                        { bufferLocation },
                                        { 'progress' },
                                        { separator = { right = '' }, },
                                        { right_padding = 2, },
                                        },
                                lualine_c =
                                        {
                                        -- { '%=' },
                                        { bufferNumber, color = { fg = colors.White } },
                                        { 'filetype' },
                                        },
                                lualine_x =
                                        {
                                        'branch',
--                                        'diff',
--                                                {
--                                                'diagnostics',
--                                                source = { 'coc' },
--                                                sections = { 'error' },
--                                                diagnostics_color = { error = { bg = colors.red, fg = colors.White } },
--                                                },
--                                                {
--                                                'diagnostics',
--                                                source = { 'coc' },
--                                                sections = { 'warn' },
--                                                diagnostics_color = { warn = { bg = colors.orange, fg = colors.White } },
--                                                },
--                                                {
--                                                'diagnostics',
--                                                source = { 'coc' },
--                                                sections = { 'info' },
--                                                diagnostics_color = { info = { bg = colors.yellow, fg = colors.White } },
--                                                },
--                                                {
--                                                'diagnostics',
--                                                source = { 'coc' },
--                                                sections = { 'hint' },
--                                                diagnostics_color = { hint = { bg = colors.LightGreen, fg = colors.White } },
--                                                },
                                        },
                                lualine_y =
                                        {
                                        { bufferSearchStatus, color = { fg = colors.White }, },
                                        },
                                lualine_z =
                                        {
                                        { 'encoding' },
                                        -- { '%=' },
                                        {
                                        bufferSpotAndColumn,
                                        separator = { left = '' },
                                        left_padding = 2,
                                        },
                                        },
                                },
                        inactive_sections =
                                {
                                lualine_a =
                                        {
                                        { 'filename', file_status = false, path = 0 },
                                        },
                                lualine_b =
                                        {
                                        { bufferChanged, color = { bg = colors.red } },
                                        },
                                lualine_c =
                                        {
                                        { bufferLocation },
                                        },
                                lualine_x = {},
                                lualine_y = {},
                                lualine_z = {},
                                },
                        tabline =
                                {
                                lualine_a = {},
                                lualine_b = {},
                                lualine_c = { 'buffers' },
                                lualine_x = {},
                                lualine_y = {},
                                lualine_z = { 'branch' },
                                },
                        extensions =
                                {
                                },
                        }
        end
        }
