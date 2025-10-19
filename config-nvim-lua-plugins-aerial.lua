return
        {
        "stevearc/aerial.nvim",
        -- https://github.com/stevearc/aerial.nvim
        opts = {},
        dependencies =
                {
                "nvim-treesitter/nvim-treesitter",
                },
        config = function()
                require("aerial").setup(
                        {
                        backends =
                                {
                                "treesitter",
                                "lsp",
                                "markdown",
                                "asciidoc",
                                "man"
                                },
                        layout =
                                {
                                min_width = { 15,   0.1 },
                                max_width = { 40.0, 0.2 },
                                width = nil,
                                default_direction = 'right',
                                placement = 'edge',
                                resize_to_content = true,
                                preserve_equality = true,
                                },
                        filter_kind =
                                {
                                "Class",
                                "Constructor",
                                "Enum",
                                "Function",
                                "Interface",
                                "Module",
                                "Method",
                                "Struct",
                                },
                        ignore =
                                {
                                unlisted_buffers = true,
                                diff_windows = true,
                                },
                        attach_mode = 'global',
                        highlight_mode = 'full_width',
                        highlight_on_hover = true,
                        highlight_on_jump = 800,
                        autojump = true,
                        manage_folds = true,
                        link_folds_to_tree = true,
                        show_guides = true,
                        guides =
                                {
                                whitespace = "  ",
                                mid_item = "├─",
                                last_item = "└─",
                                nested_top = "│ ",
                                },
                        close_automatic_events = { 'unfocus' },
                        nav =
                                {
                                border = 'rounded',
                                max_height = 0.5,
                                min_height = { 10, 0.1 },
                                max_width = 0.5,
                                min_width = { 0.2, 20 },
                                win_opts =
                                        {
                                        cursorline = true,
                                        winblend = 10,
                                        },
                                autojump = true,
                                preview = true,
                                keymaps =
                                        {
                                        ["<CR>"] = "actions.jump",
                                        ["<2-LeftMouse>"] = "actions.jump",
                                        ["<C-v>"] = "actions.jump_vsplit",
                                        ["<C-s>"] = "actions.jump_split",
                                        ["h"] = "actions.left",
                                        ["l"] = "actions.right",
                                        ["<C-c>"] = "actions.close",
                                        },
                                },
                        lsp =
                                {
                                diagnostics_trigger_update = false,
                                update_when_errors = true,
                                update_delay = 300,
                                priority = { clangd = 10, },
                                },
                        treesitter = { update_delay = 300, },
                        markdown = { update_delay = 300, },
                        asciidoc = { update_delay = 300, },
                        man = { update_delay = 300, },
                        on_attach = function(bufnr)
                                vim.keymap.set( 'n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                                vim.keymap.set( 'n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
                        end,
                        lazy_load = true,
                        nerd_font = "auto",
                        vim.keymap.set( 'n', '<leader>a', '<cmd>AerialNavToggle<CR>')
                        })
        end,
        cmd =
                {
                "Aerial",
                "AerialToggle"
                },
        keys = { { "<leader>a", "<cmd>AerialNavToggle<cr>", desc = "Toggle Aerial" }, },
        }

