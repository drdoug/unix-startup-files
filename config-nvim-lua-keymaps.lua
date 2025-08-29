--[[
                    +----------------------+----------------------+----------------------+----------------------+
                    |                                         FUNCTION KEYS                                     |
                    |                                        Neovim on MacOS                                    |
                    |                                                                                           |
                    |                      Some Keys are reserved for MacOS, see Key Codes below                }
                    |                                                                                           |
                    +----------------------+----------------------+----------------------+----------------------+
              MCSF: |                      |                      |                      |                      | 
              MC F: |                      |                      |                      |                      |
              M SF: |                      |                      |                      |                      |
               CSF: |                      |                      |                      |                      |
              M  F: |                      |Toggle Static Analysis|                      |                      |
               C F: |help                  |make distclean        |                      |                      |
                SF: |Close Current Window  |make install          |                      |Alt File Differences  |
                 F: |Close All but CurWin  |make                  |Alt File Split Below  |Alt File Split Right  |
Function Key:       |           <F1>       |           <F2>       |           <F3>       |           <F4>       |
                    +----------------------+----------------------+----------------------+----------------------+
              MCSF: |                      |                      |                      |                      | 
              MC F: |                      |                      |                      |                      |
              M SF: |                      |                      |                      |                      |
               CSF: |                      |                      |                      |                      |
              M  F: |                      |                      |                      |                      |
               C F: |   Start Live Grep    |Show "make" prompt    |                      | Use Suggested Fix    |
                SF: |Prompt for grep word  |Current Message       |Goto Previous Function|Goto Next Function    |
                 F: |Grep for *cursor      |List Messages         |Goto Previous Error   |Goto Next Error       |
Function Key:       |           <F5>       |           <F6>       |           <F7>       |           <F8>       |
                    +----------------------+----------------------+----------------------+----------------------+
              MCSF: |                      |                      |                      |                      | 
              MC F: |                      |                      |                      |                      |
              M SF: |                      |                      |                      |                      |
               CSF: |                      |                      |                      |                      |
              M  F: |                      |Toggle Fold Preview   |                      |                      |
               C F: |                      |Toggle Completion     |                      |   Plugin Manager     |
                SF: |Alternate File Split  |Toggle Side Columns   |Quit this Buffer      |                      |
                 F: |Alternate File GoTo   |Toggle Line Numbers   |List all Buffers      |   File Selector      |
Function Key:       |           <F9>       |           <F10>      |           <F11>      |           <F12>      |
                    +----------------------+----------------------+----------------------+----------------------+

                                           +----------------------+
              MCSF:                        |                      |
              MC F:                        |                      |
              M SF:                        |                      |
               CSF:                        |                      |
              M  F:                        |Go UP to Previous Diag|
               C F:                        | Show All App Windows |<- MacOS uses this
                SF:                        |Go To Prev Function   |
                 F:                        |UP Arrow              |
Key:                                       |            <Up>      |
                    +----------------------+----------------------+----------------------+
              MCSF: |                      |                      |                      |
              MC F: |Close Folding Section |                      |Open Folded Section   |
              M SF: |                      |                      |                      |
               CSF: |                      |                      |                      |
              M  F: |Goto Previous Error   |Go DOWN to Next Diag  |Goto Next Error       |
               C F: |Slide V-Desk Left     | Show App Windows     |Slide V-Desk Right    |<- MacOS uses this
                SF: |Edit Prev Buffer      |Go To Next Function   |Edit Next Buffer      |
                 F: |LEFT Arrow            |DOWN Arrow            |RIGHT Arrow           |
Key:                |          <Left>      |          <Down>      |         <Right>      |
                    +----------------------+----------------------+----------------------+
--]]

local map = vim.keymap.set

--
-- Navigation
--
map( 'n',       '<F1>',         ':on<CR>',                      { desc = 'Close All Windows except the Currently Active' })
map( 'n',       '<S-F1>',       ':wincmd c<CR>',                { desc = 'Close the Currently Active Window' })
map( 'n',       '<F2>',         ':make -j<CR>',                 { desc = 'Make' })
map( 'n',       '<S-F2>',       ':make -j install<CR>',         { desc = 'Make install' })
map( 'n',       '<C-F2>',       ':make distclean<CR>',          { desc = 'Make distclean' })
map( 'n',       '<M-F2>',       ToggleClangTidy,                { desc = 'Toggle Static Analysis Suggestions' })
map( 'n',       '<F3>',         ':split #<CR>',                 { desc = 'Split Screen Below, add Alternate File (#)' })
map( 'n',       '<F4>',         ':vsplit #<CR>',                { desc = 'Split Screen Right, add Alternate File (#)' })
map( 'n',       '<S-F4>',       ':vertical diffsplit #<CR>',    { desc = 'Show Differences with Alternate File (#)' })

map( 'n',       '<F5>',         SearchProjectFromCursor,        { desc = 'Search Project for Word beneath Cursor' })
map( 'n',       '<F17>',        SearchProjectFromPrompt,        { desc = 'Prompt User for Pattern then Search Project' })
map( 'n',       '<F29>',        StartLiveGrep,                  { desc = 'Grep Live while Typing' })
map( 'n',       '<F6>',         ':clist<CR>',                   { desc = 'Show All Search or Error Messages' })
map( 'n',       '<F18>',        ':cc<CR>',                      { desc = 'Show Current Search or Error Message' })
map( 'n',       '<F7>',         ':cprev<CR>',                   { desc = 'Jump to Previous Found Location' })
map( 'n',       '<F8>',         ':cnext<CR>',                   { desc = 'Jump to Next Found Location' })
map( 'n',       '<F19>',        ':AerialPrev<CR>',              { desc = 'Jump to Previous Function in File' })
map( 'n',       '<F20>',        ':AerialNext<CR>',              { desc = 'Jump to Next Function in File' })
map( 'n',       '<F32>',        vim.lsp.buf.code_action,        { desc = 'Use Suggested Fix(es) when Problems are Found' })
map( 'n',       '<F9>',         ':e#<CR>',                      { desc = 'Switch to Most Recent Buffer' })
map( 'n',       '<F21>',        ':split #<CR>',                 { desc = 'Split Screen then Switch to Most Recent Buffer' })
map( 'n',       '<F10>',        CycleLineNumberModes,           { desc = 'Show Line Numbers, Relative or None' })
map( 'n',       '<F22>',        ToggleSideColumns,              { desc = 'Show or Hide Left Columns for Folds and Indicators' })
map( 'n',       '<F34>',        ToggleCodeCompletion,           { desc = 'Toggle Code Completion Suggestions' })
map( 'n',       '<F58>',        ToggleFoldPreview,              { desc = 'Toggle Fold Preview' })
map( 'n',       '<F11>',        ':buffers<CR>',                 { desc = 'Show All Current Buffers' })
map( 'n',       '<F36>',        ':Lazy home<CR>',               { desc = 'Show Plugin Manager Status' })

--
-- buffers and navigation
--
map( 'n',       '<M-Left>',     ':cprev<CR>',                   { desc = 'Jump to Previous Found Location' })
map( 'n',       '<M-Right>',    ':cnext<CR>',                   { desc = 'Jump to Next Found Location' })
map( 'n',       '<M-Up>',       vim.diagnostic.goto_prev,       { desc = 'Go Up to Location of Previous Diagnostic Message' })
map( 'n',       '<M-Down>',     vim.diagnostic.goto_next,       { desc = 'Go Down to Location of Next Diagnostic Message' })
map( 'n',       '<S-Left>',     ':bp<CR>',                      { desc = 'Switch to Previous Buffer' })
map( 'n',       '<S-Right>',    ':bn<CR>',                      { desc = 'Switch to Next Buffer' })
map( 'n',       '<S-Up>',       '[m',                           { desc = 'Switch to Previous Window' })
map( 'n',       '<S-Down>',     ']m',                           { desc = 'Switch to Next Window' })
map( 'n',       '<M-C-Left>',   'zc',                           { desc = 'Close the foldable segment starting beneath the cursor' })
map( 'n',       '<M-C-Right>',  'zo',                           { desc = 'Open the folded segment at the cursor' })
map( 'n',       '<M-C-S-Left>', 'zM',                           { desc = 'Close ALL foldable segments' })
map( 'n',       '<M-C-S-Right>','zR',                           { desc = 'Open ALL folded segments' })
--
-- neo-tree support
--
local builtin = require('telescope.builtin')
map( 'n',       '<F12>',        ShowFilesystem,                 { desc = 'Directory Viewer' })
map( 'n',       '<leader>ff',   builtin.find_files,             { desc = 'Telescope find files' })
map( 'n',       '<leader>fg',   builtin.live_grep,              { desc = 'Telescope live grep' })
map( 'n',       '<leader>fb',   builtin.buffers,                { desc = 'Telescope buffers' })
map( 'n',       '<leader>fh',   builtin.help_tags,              { desc = 'Telescope help tags' })
--
-- language support
--
map( 'n',       'K',            vim.lsp.buf.hover,                      {})
map( 'n',       '<C-k>',        vim.lsp.buf.signature_help,             {})
map( 'n',       '<leader>gD',   vim.lsp.buf.declaration,                {})
map( 'n',       '<leader>gd',   vim.lsp.buf.definition,                 {})
map( 'n',       '<leader>gi',   vim.lsp.buf.implementation,             {})
map( 'n',       '<leader>ca',   vim.lsp.buf.code_action,                {})
map( 'v',       '<leader>ca',   vim.lsp.buf.code_action,                {})
map( 'n',       '<leader>wa',   vim.lsp.buf.add_workspace_folder,       {})
map( 'n',       '<leader>wr',   vim.lsp.buf.remove_workspace_folder,    {})
map( 'n',       '<leader>wl',   function()
                                        print( vim.inspect( vim.lsp.buf.list_workspace_folders()))
                                        end,                            {})
map( 'n',       '<leader>D',    vim.lsp.buf.type_definition,            {})
map( 'n',       '<leader>rn',   vim.lsp.buf.rename,                     {})
map( 'n',       '<leader>gr',   vim.lsp.buf.references,                 {})
map( 'n',       '<leader>f',    function()
                                        vim.lsp.buf.format              { async = true }
                                end,                                    {})

-- ---------------------NEW STARTS HERE ---------------------

-- Window Splitting
map( 'n',       '<leader>spv',  '<C-w>v')
map( 'n',       '<leader>sph',  '<C-w>s')
map( 'n',       '<leader>spe',  '<C-w>=')
map( 'n',       '<leader>spx',  ':close<CR>')

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<CR>")
map("n", "<leader>tn", "<cmd>tabn<CR>")
map("n", "<leader>tp", "<cmd>tabp<CR>")
map("n", "<leader>tml", "<cmd>tabmove +1<CR>")
map("n", "<leader>tmr", "<cmd>tabmove -1<CR>")

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>")

-------------------------------------------------------------------------------------------------------

-- ~  Plugin keymaps


-- Telescope
map("n", "<leader>?", "<cmd>Telescope oldfiles<CR>", { desc = "[?] Find recently opened files" })
map("n", "<leader><space>", "<cmd>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "[/] Fuzzily search in current buffer]" })
map("n", "<leader>tb", "<cmd>Telescope builtin<CR>", { desc = "[T]elescope [B]uiltin" })
map("n", "<leader>tsf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
map("n", "<leader>tsh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
map("n", "<leader>tsw", "<cmd>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" })
map("n", "<leader>tsg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
map("n", "<leader>tsd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "[F]ile [B]rowser" }, { noremap = true })

-- Git
map("n", "<leader>gbt", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "[G]it [B]lame [T]oggle"})

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>df", vim.diagnostic.open_float)
map("n", "<leader>de", vim.diagnostic.setloclist)

-- Zen
map("n", "<leader>zn", "<cmd>TZNarrow<CR>", { noremap = true })
map("v", "<leader>zn", "<cmd>'<,'>TZNarrow<CR>", { noremap = true })
map("n", "<leader>zf", "<cmd>TZFocus<CR>", { noremap = true })
map("n", "<leader>zm", "<cmd>TZMinimalist<CR>", { noremap = true })
map("n", "<leader>za", "<cmd>TZAtaraxis<CR>", { noremap = true })

-- Tmux
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { noremap = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { noremap = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true })


--[[
                    +----------------------+----------------------+----------------------+----------------------+
                    |                                         Function Keys                                     |
                    |                                          KEY CODES                                        |
                    |                     Use the following codes in neovim's MAP command                       |
                    |           Function Keys Recognized by Neovim on MacOS Keyboards, including external.      |
                    |           NOTE: C-F8 and F11 must be disabled in System Prefs (See Mac in Notes App)      |
                    +----------------------+----------------------+----------------------+----------------------+
Shift-Ctrl-Alt-Key: |           <M-C-S-F1> |           <M-C-S-F2> |           <M-C-S-F3> |           <M-C-S-F4> | 
Ctrl-Alt-Key:       |           <M-C-F1>   |           <M-C-F2>   |           <M-C-F3>   |           <M-C-F4>   |
Shift-Alt-Key:      |           <M-S-F1>   |           <M-S-F2>   |           <M-S-F3>   |           <M-S-F4>   |
Shift-Ctrl-Key:     |           <C-S-F1>   |           <C-S-F2>   |           <C-S-F3>   |           <C-S-F4>   |
Alt-Key:            |           <M-F1>     |           <M-F2>     |           <M-F3>     |           <M-F4>     |
Ctrl-Key:           |           <C-F1>     |           <C-F2>     |           <C-F3>     |           <C-F4>     |
Shift-Key:          |           <S-F1>     |           <S-F2>     |           <S-F3>     |           <S-F4>     |
Function Key:       |           <F1>       |           <F2>       |           <F3>       |           <F4>       |
                    +----------------------+----------------------+----------------------+----------------------+
Shift-Ctrl-Alt-Key: |           <M-C-S-F5> |           <M-C-S-F6> |           <M-C-S-F7> |           <M-C-S-F8> |
Ctrl-Alt-Key:       |           <M-C-F5>   |           <M-C-F6>   |           <M-C-F7>   |           <M-C-F8>   |
Shift-Alt-Key:      |           <M-S-F5>   |           <M-S-F6>   |           <M-S-F7>   |           <M-S-F8>   |
Shift-Ctrl-Key:     |           <F41>      |           <F42>      |           <F43>      |           <F44>      |
Alt-Key:            |           <F53>      |           <F54>      |           <F55>      |           <F56>      |
Ctrl-Key:           |           <F29>      |           <F30>      |           <F31>      |           <F32>      |
Shift-Key:          |           <F17>      |           <F18>      |           <F19>      |           <F20>      |
Function Key:       |           <F5>       |           <F6>       |           <F7>       |           <F8>       |
                    +----------------------+----------------------+----------------------+----------------------+
Shift-Ctrl-Alt-Key: |           <M-C-S-F9> |           <M-C-S-F10>|           <M-C-S-F11>|           <M-C-S-F12>|
Ctrl-Alt-Key:       |           <M-C-F9>   |           <M-C-F10>  |           <M-C-F11>  |           <M-C-F12>  |
Shift-Alt-Key:      |           <M-S-F9>   |           <M-S-F10>  |           <M-S-F11>  |           <M-S-F12>  |
Shift-Ctrl-Key:     |           <F45>      |           <F46>      |           <F47>      |           <F48>      |
Alt-Key:            |           <F57>      |           <F58>      |           <F59>      |           <F60>      |
Ctrl-Key:           |           <F33>      |           <F34>      |           <F35>      |           <F36>      |
Shift-Key:          |           <F21>      |           <F22>      |           <F23>      |           <F24>      |
Function Key:       |           <F9>       |           <F10>      |           <F11>      |           <F12>      |
                    +----------------------+----------------------+----------------------+----------------------+

                                           +----------------------+
Shift-Ctrl-Alt-Key:                        |            <M-C-S-Up>|
Ctrl-Alt-Key:                              |            <M-C-Up>  |
Shift-Alt-Key:                             |            <M-S-Up>  |
Shift-Ctrl-Key:                            |            <C-S-Up>  |
Alt-Key:                                   |            <M-Up>    |
Ctrl-Key:                                  |            <C-Up>    |
Shift-Key:                                 |            <S-Up>    |
                    +----------------------+----------------------+----------------------+
Shift-Ctrl-Alt-Key: |          <M-C-S-Left>|          <M-C-S-Down>|         <M-C-S-Right>|
Ctrl-Alt-Key:       |          <M-C-Left>  |          <M-C-Down>  |         <M-C-Right>  |
Shift-Alt-Key:      |          <M-S-Left>  |          <M-S-Down>  |         <M-S-Right>  |
Shift-Ctrl-Key:     |          <C-S-Left>  |          <C-S-Down>  |         <C-S-Right>  |
Alt-Key:            |          <M-Left>    |          <M-Down>    |         <M-Right>    |
Ctrl-Key:           |          <C-Left>    |          <C-Down>    |         <C-Right>    |
Shift-Key:          |          <S-Left>    |          <S-Down>    |         <S-Right>    |
                    +----------------------+----------------------+----------------------+

--]]
