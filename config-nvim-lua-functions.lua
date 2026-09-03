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
                print( "Quickfix list is empty!")
                return
        end

        -- Categorize and print entries
        for _, entry in ipairs( qflist) do
                local message = string.format(
                                "[%s:%d:%d] %s",
                                entry.filename or "N/A",
                                entry.lnum or 0,
                                entry.col or 0,
                                entry.text or "No message"
                                )
                print( message)
        end
end

--
-- Show a popup window with a
-- filesystem listing for navigation
--
function ShowFilesystem()
        vim.cmd( "Neotree filesystem toggle")
end

function ToggleFoldPreview()
        local winid = require( "ufo").peekFoldedLinesUnderCursor()
        if not winid
        then
                vim.lsp.buf.hover()
        end
end

--
-- Toggle the state of the
-- autocompletion function
--
function ToggleCodeCompletion()
        vim.b.completion = not vim.b.completion

        if vim.b.completion then
                print( "Code Completion: enabled")
        else
                print( "Code Completion: disabled")
        end
end

--
-- Perform live grep
--
function StartLiveGrep()
        require( 'telescope.builtin').live_grep()
end

--
-- Show a floating window with function key
-- and arrow key binding reference
--
function ShowKeyHelp()
        local keymaps_path = vim.fn.stdpath('config') .. '/lua/keymaps.lua'
        local ok, all_lines = pcall(vim.fn.readfile, keymaps_path)
        if not ok then
                vim.notify('Cannot read keymaps.lua', vim.log.levels.ERROR)
                return
        end

        local content = {}
        local in_block = false
        for _, line in ipairs(all_lines) do
                if line == '--[[' then
                        in_block = true
                elseif line == '--]]' then
                        in_block = false
                        table.insert(content, '')
                elseif in_block then
                        table.insert(content, line)
                end
        end

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
        vim.bo[buf].modifiable = false
        vim.bo[buf].bufhidden = 'wipe'

        local max_width = 0
        for _, line in ipairs(content) do
                max_width = math.max(max_width, #line)
        end
        local width  = math.min(max_width + 2, vim.o.columns - 4)
        local height = math.min(#content,       vim.o.lines   - 4)
        local row    = math.floor((vim.o.lines   - height) / 2)
        local col    = math.floor((vim.o.columns - width)  / 2)

        local win = vim.api.nvim_open_win(buf, true, {
                relative   = 'editor',
                width      = width,
                height     = height,
                row        = row,
                col        = col,
                style      = 'minimal',
                border     = 'rounded',
                title      = ' Key Reference ',
                title_pos  = 'center',
        })
        vim.wo[win].wrap = false

        vim.keymap.set('n', 'q',     '<cmd>close<CR>', { buffer = buf, silent = true })
        vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, silent = true })
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

        for _, client in ipairs( vim.lsp.get_clients( { name = "clangd" })) do
                vim.lsp.stop_client( client.id, true)
        end

        require( 'lspconfig').clangd.setup(
                {
                cmd = new_cmd,
                -- on_attach = function( client, bufnr)
                -- -- Your existing on_attach code here
                -- end,
                -- capabilities = require( 'cmp_nvim_lsp').default_capabilities()
                })

        vim.cmd( "edit")  -- reload the buffer to trigger clangd restart
        print( "Clang-Tidy " .. ( clangd_enabled and "enabled" or "disabled"))
end

