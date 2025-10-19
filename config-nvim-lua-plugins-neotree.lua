return
        {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies =
                {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
                },
        config = function()
                vim.api.nvim_create_autocmd("FileType",
                        {
                        pattern = "neo-tree",
                        callback = function()
                                vim.opt_local.number = true
                                vim.opt_local.relativenumber = true
                        end,
                        })
                require( 'neo-tree').setup(
                        {
                        close_if_last_window = false,
                        popup_border_style = 'rounded',
                        enable_git_status = true,
                        enable_diagnostics = true,
                        sources = { "filesystem" }, -- Ensure filesystem is enabled
                        window =
                                {
                                position = "float",
                                popup =
                                        {
                                        size =
                                                {
                                                height = 0.99, -- 80% of the height of the editor
                                                width = 0.35, -- 20% of the width of the editor
                                                },
                                        border = "rounded", -- Rounded border for the popup
                                               mappings =
                                                       {
                                                       ["<space>"] =
                                                               {
                                                               "toggle_node",
                                                               nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
                                                               },
                                                       ["<2-LeftMouse>"] = "open_drop",
                                                       ["<cr>"] = "open_drop",
                                                       ["<esc>"] = "cancel", -- close preview or floating neo-tree window
                                                       },
                                        },
                                default_component_configs =
                                        {
                                        container =
                                                {
                                                enable_character_fade = true
                                                },
                                        indent =
                                                {
                                                indent_size = 4,
                                                padding = 1, -- extra padding on left hand side
                                                -- indent guides
                                                with_markers = true,
                                                indent_marker = '│',
                                                last_indent_marker = '└',
                                                highlight = 'NeoTreeIndentMarker',
                                                -- expander config, needed for nesting files
                                                with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                                                expander_collapsed = ' ',
                                                expander_expanded = ' ',
                                                expander_highlight = 'NeoTreeExpander',
                                                },
                                        icon =
                                                {
                                                folder_closed = ' ',
                                                folder_open = ' ',
                                                folder_empty = '󰜌 ',
                                                provider = function(icon, node, _) -- default icon provider utilizes nvim-web-devicons if available
                                                        if node.type == 'file' or node.type == 'terminal' then
                                                                local success, web_devicons = pcall(require, 'nvim-web-devicons')
                                                                local name = node.type == 'terminal' and 'terminal' or node.name
                                                                if success then
                                                                        local devicon, hl = web_devicons.get_icon(name)
                                                                        icon.text = devicon or icon.text
                                                                        icon.highlight = hl or icon.highlight
                                                                end
                                                        end
                                                end,
                                                -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                                                -- then these will never be used.
                                                default = '*',
                                                highlight = 'NeoTreeFileIcon'
                                                },
                                        modified =
                                                {
                                                symbol = " ",
                                                highlight = "NeoTreeModified",
                                                },
                                        name =
                                                {
                                                trailing_slash = false,
                                                use_git_status_colors = true,
                                                -- highlight = "NeoTreeFileName",
                                                highlight_opened_files = true,
                                                },
                                        git_status =
                                                {
                                                symbols =
                                                        {
                                                        -- Change type
                                                        added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                                                        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                                                        deleted   = "✖",-- this can only be used in the git_status source
                                                        renamed   = "󰁕",-- this can only be used in the git_status source
                                                        -- Status type
                                                        untracked = "",
                                                        ignored   = "",
                                                        unstaged  = "󰄱",
                                                        staged    = "",
                                                        conflict  = "",
                                                        }
                                                },
                                        file_size =
                                                {
                                                enabled = false,
                                                required_width = 50, -- min width of window required to show this column
                                                },
                                        type =
                                                {
                                                enabled = true,
                                                required_width = 122, -- min width of window required to show this column
                                                },
                                        last_modified =
                                                {
                                                enabled = false,
                                                required_width = 88, -- min width of window required to show this column
                                                },
                                        created =
                                                {
                                                enabled = false,
                                                required_width = 110, -- min width of window required to show this column
                                                },
                                        symlink_target =
                                                {
                                                enabled = false,
                                                },
                                        },
                                },
                        filesystem =
                                {
                                follow_current_file =
                                        {
                                        enabled = true,    -- highlight the file you are currently editing
                                        leave_dirs_open = false, -- optional: keep parent folders open
                                        },
                                filtered_items =
                                        {
                                        hide_dotfiles = false,
                                        hide_gitignored = false,
                                        },
                                },
                        })
                end
        }
