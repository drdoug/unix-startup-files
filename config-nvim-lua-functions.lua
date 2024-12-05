--
-- Hide or Show Line Numbers
--
local _showNumbers=true
function ToggleLineNumbers()
        if _showNumbers
        then
                vim.cmd( 'set nonu nornu')
                -- vim.cmd( 'set statuscolumn=""')
                _showNumbers = false
        else
                vim.cmd( 'set nu rnu')
                -- vim.cmd( 'set statuscolumn="%=%{v:relnum?v:relnum:v:lnum} "')
                _showNumbers = true
        end
end

--
-- Search project source code files for
-- the given pattern, showing the full
-- quickfixlist if showAllResults is true
--
local function searchForPattern( pattern, showAllResults)
        local gCmd = string.format( "rg --vimgrep --type-add 'source:*.{h,c,cc,hpp,cpp,py,js,md,ts,java,txt,rb,go,rs,php,lua}' -t source %s", vim.fn.shellescape( pattern))
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
        end
        vim.cmd( "wincmd p")
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
        searchForPattern( word, false)
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
