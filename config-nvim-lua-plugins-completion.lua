return
        {
        'saghen/blink.cmp',
        dependencies =
                {
                'rafamadriz/friendly-snippets'
                },

        -- from https://github.com/d7omdev/nvim/blob/master/lua/plugins/blink.lua

        version = '1.*',
        opts_extend =
                {
                'sources.completion.enabled.providers',
                'sources.compat',
                'sources.default',
                },
        enabled = function()
                return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
                -- return false
                -- return true
        end,

        event = 'InsertEnter',
        opts =
                {
                sources =
                        {
                        default = { "snippets", "lsp", "path", "buffer" },
                        providers =
                                {
                                snippets =
                                        {
                                        min_keyword_length = 1,
                                        score_offset = 4,
                                        },
                                lsp =
                                        {
                                        min_keyword_length = 0,
                                        score_offset = 3,
                                        name = "LSP",
                                        module = "blink.cmp.sources.lsp",
                                        fallbacks = {},
                                        },
                                path =
                                        {
                                        min_keyword_length = 0,
                                        score_offset = 2,
                                        },
                                buffer =
                                        {
                                        min_keyword_length = 1,
                                        score_offset = 1,
                                        },
                                },
                        },
                cmdline =
                        {
                        enabled = true,
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        sources = function()
                                local type = vim.fn.getcmdtype()

                                if type == "/" or type == "?" -- Search forward and backward
                                then
                                        return { "buffer" }
                                end

                                if type == ":" or type == "@" -- Commands
                                then
                                        return { "cmdline" }
                                end

                                return {}
                        end,
                        keymap =
                                {
                                ["<Down>"] = { "select_next", "fallback" },
                                ["<Up>"] = { "select_prev", "fallback" },
                                },
                        completion =
                                {
                                menu =
                                        {
                                        auto_show = true,
                                        draw =
                                                {
                                                columns =
                                                        {
                                                                {
                                                                "kind_icon",
                                                                "label",
                                                                "label_description",
                                                                gap = 1
                                                                }
                                                        },
                                                },
                                        },
                                },
                        },
                completion =
                        {
                        accept =
                                {
                                auto_brackets =
                                        {
                                        enabled = true,
                                        },
                                },
                        menu =
                                {
                                border = "single",
                                draw =
                                        {
                                        columns =
                                                {
                                                { "label", gap = 10 },
                                                { "kind_icon", gap = 1 },
                                                { "kind" },
                                                { "label_description" },
                                                },

                                        gap = 1,
                                        treesitter = { "lsp" },
                                        },
                                },
                        list =
                                {
                                selection =
                                        {
                                        preselect = false,
                                        auto_insert = true
                                        },
                                },
                        documentation =
                                {
                                auto_show = true,
                                auto_show_delay_ms = 200,
                                window =
                                        {
                                        border = "single",
                                        },
                                },
                        ghost_text =
                                {
                                enabled = true,
                                },
                        },
                signature =
                        {
                        enabled = true,
                        window = { border = "single" }
                        },
                appearance =
                        {
                        kind_icons =
                                {
                                Text = "󰉿",
                                Method = "",
                                Function = "󰊕",
                                Constructor = "󰒓",
                                Field = "",
                                Variable = "󰆦",
                                Property = "󰖷",
                                Class = "",
                                Interface = "",
                                Struct = "󱡠",
                                Module = "󰅩",
                                Unit = "󰪚",
                                Value = "",
                                Enum = "",
                                EnumMember = "",
                                Keyword = "",
                                Constant = "󰏿",
                                Snippet = "",
                                Color = "󰏘",
                                File = "󰈔",
                                Reference = "󰬲",
                                Folder = "󰉋",
                                Event = "󱐋",
                                Operator = "󰪚",
                                TypeParameter = "󰬛",
                                Error = "󰏭",
                                Warning = "",
                                Information = "󰋼",
                                Hint = "",
                                },
                        },
                keymap =
                        {
                        preset = "enter",
                        ['<C-y>'] = { 'select_and_accept' },
                        },
                },
        }
