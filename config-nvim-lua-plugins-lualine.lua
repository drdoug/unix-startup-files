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
                        return ' (' .. searchcount.current .. ' of ' .. searchcount.total .. ')'
                end

                local function bufferChanged()
                        if vim.bo.modified then
                                return '●'
                        end
                        return ''
                end
                local function bufferReadonly()
                        if vim.bo.modifiable == false or vim.bo.readonly == true then
                                return ' '
                        end
                        return ''
                end

                local function bufferLocation()
                        return ' Line %l of %L '
                end

                local function bufferNumber()
                        return 'buf %n'
                end

                local function bufferSpotAndColumn()
                        return 'Sym=0x%B [Col %c%V]'
                end

                local colors =
                        {
                        Black           = '#000000',
                        White           = '#f3f3f3',
                        DarkBlue        = '#0000CD',
                        MediumBlue      = '#4876FF',
                        DarkGreen       = '#006400',
                        LightGreen      = '#90EE90',
                        DarkGrey        = '#303050',
                        MediumGrey      = '#696969',
                        LightGrey       = '#999999',
                        DarkRed         = '#881038',
                        Red             = '#FF0000',
                        Yellow          = '#FFFF00',
                        pink            = '#FFC0CB',
                        salmon          = '#FA8072',
                        magenta         = '#FF00FF',
                        goldenrod       = '#FFD700',
                        DiagnosticError = '#f76464',
                        DiagnosticWarn  = '#f7bf64',
                        DiagnosticInfo  = '#64bcf7',
                        DiagnosticHint  = '#64f79d',
                        }

                local auroraTheme =
                        {
                        normal =
                                {
                                a = { fg = colors.White, bg = colors.MediumBlue },
                                b = { fg = colors.White, bg = colors.DarkBlue },
                                c = { fg = colors.White, bg = colors.DarkGrey },
                                x = { fg = colors.White, bg = colors.DarkGreen },
                                y = { fg = colors.White, bg = colors.DarkBlue },
                                z = { fg = colors.White, bg = colors.MediumBlue },
                                },
                        insert =
                                {
                                a = { fg = colors.Black, bg = colors.LightGreen },
                                },
                        visual =
                                {
                                a = { fg = colors.Black, bg = colors.salmon },
                                },
                        replace =
                                {
                                a = { fg = colors.White, bg = colors.DarkRed },
                                },
                        command =
                                {
                                a = { fg = colors.Black, bg = colors.goldenrod },
                                },
                        }

                require( 'lualine').setup
                        {
                        options =
                                {
                                theme = auroraTheme,
                                always_show_tabline = true,
                                component_separators =
                                        {
                                        left = '',
                                        right = ''
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
                                        }
                                        },
                                lualine_b =
                                        {
                                        { 'filename', file_status = false, path = 0 },
                                        { bufferChanged, color = { fg = colors.magenta } },
                                        { bufferReadonly, color = { fg = colors.magenta } },
                                        { bufferLocation, color = { fg = colors.pink } },
                                        { 'progress' },
                                        { separator = { right = '' }, },
                                        { right_padding = 2, },
                                        },
                                lualine_c =
                                        {
                                        { 'filetype', colored = false, icon = { align = 'left' }, },
                                        { bufferNumber, color = { fg = colors.White } },
                                        { '%=' },
                                        {
                                        'diagnostics',
                                        sections =
                                                {
                                                'error',
                                                'warn',
                                                'info',
                                                'hint',
                                                },
                                        diagnostics_color =
                                                {
                                                error = { fg = colors.DiagnosticError,  bg = colors.DarkGrey },
                                                warn  = { fg = colors.DiagnosticWarn,   bg = colors.DarkGrey },
                                                info  = { fg = colors.DiagnosticInfo,   bg = colors.DarkGrey },
                                                hint  = { fg = colors.DiagnosticHint,   bg = colors.DarkGrey },
                                                -- error = { fg = colors.Red, bg = colors.DarkGrey },
                                                -- warn  = { fg = colors.Yellow, bg = colors.DarkGrey },
                                                -- info  = { fg = colors.LightGreen, bg = colors.DarkGrey },
                                                -- hint  = { fg = colors.goldenrod, bg = colors.DarkGrey },
                                                },
                                        symbols =
                                                {
                                                error = ' ',
                                                warn = ' ',
                                                info = ' ',
                                                hint = '󰛨 ',
                                                },
                                        colored = true,
                                        },
                                        },
                                lualine_x =
                                        {
                                        {
                                        'branch',
                                        separator = { left = '' },
                                        left_padding = 2,
                                        },
                                        },
                                lualine_y =
                                        {
                                        { bufferSearchStatus, color = { fg = colors.White } },
                                        },
                                lualine_z =
                                        {
                                        { 'encoding' },
                                        {
                                        'fileformat',
                                        symbols =
                                                {
                                                mac = '',  -- e711
                                                unix = '󰍹 ', -- f0379
                                                dos = '',  -- e70f
                                                },
                                        },
                                        { '=%' },
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
                                        {
                                        'mode',
                                        color = { fg = colors.Black, bg = colors.LightGrey },
                                        icons_enabled = true,
                                        separator = { right = '' },
                                        right_padding = 2,
                                        fmt = function( str)
                                                return str:sub( 1, 9)
                                        end
                                        }
                                        },
                                lualine_b =
                                        {
                                        {
                                        'filename',
                                        color = { fg = colors.pink, bg = colors.MediumGrey },
                                        icons_enabled = true,
                                        file_status = false,
                                        path = 0,
                                        separator = { right = '' },
                                        right_padding = 2,
                                        }
                                        },
                                lualine_c =
                                        {
                                        { bufferNumber, color = { fg = colors.White }, },
                                        { '%=' },
                                        },
                                lualine_x = {},
                                lualine_y = {},
                                lualine_z =
                                        {
                                        { '%=', color = { fg = colors.White, bg = colors.MediumGrey }, },
                                        {
                                        color = { fg = colors.Black, bg = colors.LightGrey },
                                        separator = { left = '' },
                                        left_padding = 2,
                                        },
                                        },
                                },
                        tabline =
                                {
                                lualine_a =
                                        {
                                        'buffers',
                                        },
                                lualine_b = {},
                                lualine_c = {},
                                lualine_x = {},
                                lualine_y =
                                        {
                                        {
                                        'branch',
                                        separator = { left = '' },
                                        },
                                        },
                                lualine_z = { bufferNumber },
                                },
                        extensions =
                                {
                                'nvim-tree',
                                },
                        }
        end
        }
