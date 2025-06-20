--
-- Cycle between line numbers, relative line numbers
-- or no line numbers. Default is relative numbers.
--
function CycleLineNumberModes()
        local number = vim.wo.number
        local relativenumber = vim.wo.relativenumber

        if not number and not relativenumber
        then
                vim.wo.number = true
                vim.wo.relativenumber = false
            elseif number and not relativenumber
            then
                vim.wo.relativenumber = true
            elseif number and relativenumber
            then
                vim.wo.number = false
                vim.wo.relativenumber = false
        end
end

--
-- Hide or Show Fold and Sign Columns on Left
--
local _showColumns=true
function ToggleSideColumns()
        if _showColumns
        then
                vim.opt.foldcolumn="0"
                vim.opt.signcolumn="no"
                _showColumns = false
        else
                vim.opt.foldcolumn="1"
                vim.opt.signcolumn="yes"
                _showColumns = true
        end
end

--
-- Search project source code files for
-- the given pattern, showing the full
-- quickfixlist if showAllResults is true
--
local function searchForPattern( pattern, showAllResults)
        local gCmd = string.format( "rg --vimgrep --sort=path --type-add 'source:*.{h,c,cc,hpp,cpp,py,js,md,ts,java,txt,rb,go,rs,php,lua}' -t source %s", vim.fn.shellescape( pattern))
        local gOut = vim.fn.systemlist( gCmd)

        if vim.v.shell_error ~= 0 then
                print( "Can't Find Instances of " .. pattern .. '\n')
                return
        end

        vim.fn.setqflist( {}, 'r', { title = "Search Results", lines = gOut })
        print( "Search results for '" .. pattern .. "' added to quickfix list.")
        if showAllResults == true
        then
                vim.cmd( "copen")
                vim.cmd( "wincmd p")
        end
end

--
-- Search recursively for instances of
-- the word beneath the user's cursor
--
function SearchProjectFromCursor()
        local word = vim.fn.expand( "<cword>")
        if word == ""
        then
                print( "No word under cursor")
                return
        end
        word = "\\<" .. word .. "\\>"
        searchForPattern( word, false)
        vim.cmd( "cfirst")
        vim.cmd( "clist")
end

--
-- Search recursively for instances of
-- the pattern requested by the prompt
--
function SearchProjectFromPrompt()
        vim.ui.input( { prompt = "Enter pattern for Search: " }, function( pattern)
                if pattern ~= ""
                then
                        searchForPattern( pattern, false)
                        vim.cmd( "cc1")
                end
        end)
end

--
-- Review QuickFix List
--
function ListQFix()
        local qflist = vim.fn.getqflist()

        if #qflist == 0 then
                print("Quickfix list is empty!")
                return
        end

        -- Categorize and print entries
        for _, entry in ipairs(qflist) do
                local message = string.format(
                                "[%s:%d:%d] %s",
                                entry.filename or "N/A",
                                entry.lnum or 0,
                                entry.col or 0,
                                entry.text or "No message"
                                )
                print(message)
        end
end

--
-- Show a popup window with a
-- filesystem listing for navigation
--
function ShowFilesystem()
        -- return ":Neotree action=focus source=filesystem position=float toggle=true dir=. reveal=true<CR>"
        local neotree = require('neo-tree')

        neotree.setup(
                {
                sources = { "filesystem" }, -- Ensure filesystem is enabled
                window =
                        {
                        position = "float",
                        popup =
                                {
                                size =
                                        {
                                        height = 0.6, -- 80% of the height of the editor
                                        width = 0.5, -- 80% of the width of the editor
                                        },
                                border = "rounded", -- Rounded border for the popup
                                },
                        },
                })
        vim.cmd( "Neotree float filesystem")
end

--
-- Toggle the state of the
-- autocompletion function
--
function ToggleCodeCompletion()
        vim.b.completion = not vim.b.completion

        if vim.b.completion then
                print("Code Completion: enabled")
        else
                print("Code Completion: disabled")
        end
end

--
-- Perform live grep
--
function StartLiveGrep()
        require( 'telescope.builtin').live_grep
                {
                noremap = true,
                silent = true,
                }
end

--
-- Toggle C++11 Static Code Analysis
--
local clangd_cmd_with_tidy = { "clangd", "--clang-tidy" }
local clangd_cmd_without_tidy = { "clangd" }

local clangd_enabled = false

function ToggleClangTidy()
        clangd_enabled = not clangd_enabled
        local new_cmd = clangd_enabled and clangd_cmd_with_tidy or clangd_cmd_without_tidy

        vim.lsp.stop_client( vim.lsp.get_active_clients( { name = "clangd" }), true)

        require('lspconfig').clangd.setup(
                {
                cmd = new_cmd,
                -- on_attach = function( client, bufnr)
                -- -- Your existing on_attach code here
                -- end,
                -- capabilities = require( 'cmp_nvim_lsp').default_capabilities()
                })

        vim.cmd("edit")  -- reload the buffer to trigger clangd restart
        print("Clang-Tidy " .. ( clangd_enabled and "enabled" or "disabled"))
end

