--[[
           +--------------------+--------------------+--------------------+--------------------+
           |                                   FUNCTION KEYS                                   |
           |           Function Key Mapping for Neovim on MacOS External Keyboard              |
           |   Keymap for standard keyboard using a Terminal Emulator (iTerm2, XTerm, etc)     |
           |    NOTE: C-F8 and F11 must be disabled in System Prefs (See Mac in Notes App)     |
           +--------------------+--------------------+--------------------+--------------------+
     CTRL: |help                |make distclean      |                    |                    |
     SHFT: |Close Current Window|make install        |                    |Alt File Differences|
     FUNC: |Close All but CurWin|make                |Alt File Split Below|Alt File Split Right|
 Control:  |              <C-F1>|              <C-F2>|              <C-F3>|              <C-F4>|
 Shift:    |              <S-F1>|              <S-F2>|              <S-F3>|              <S-F4>|
 Key:      |                <F1>|                <F2>|                <F3>|                <F4>|
           +--------------------+--------------------+--------------------+--------------------+
     CTRL: |   Start Live Grep  |Show "make" prompt  |                    | Use Suggested Fix  |
     SHFT: |Prompt for grep word|Current Message     |                    |                    |
     FUNC: |Grep for *cursor    |List Messages       |Goto Previous Error |Goto Next Error     |
 Control:  |               <F29>|               <F30>|               <F31>|               <F32>|
 Shift:    |               <F17>|               <F18>|               <F19>|               <F20>|
 Key:      |               <F5> |               <F6> |               <F7> |               <F8> |
           +--------------------+--------------------+--------------------+--------------------+
     CTRL: |                    |Toggle Completion   |                    |   Plugin Manager   |
     SHFT: |Alternate File Split|Toggle Side Columns |Quit this Buffer    |                    |
     FUNC: |Alternate File GoTo |Toggle Line Numbers |List all Buffers    |   File Selector    |
 Control:  |               <F33>|               <F34>|               <F35>|               <F36>|
 Shift:    |               <F21>|               <F22>|               <F23>|               <F24>|
 Key:      |               <F9> |               <F10>|               <F11>|               <F12>|
           +--------------------+--------------------+--------------------+--------------------+
                                                     +--------------------+
 Control:                                            | Show All Windows   |                     <- MacOS
 Shift:                                              |Go To Prev Window   |
 Function:                                           |Move Cursor up      |
 Key:                                                |UP Arrow            |
                                +--------------------+--------------------+--------------------+
 Control:                       |Slide V-Desk Left   | Show App Windows   |Slide V-Desk Right  |<- MacOS
 Shift:                         |Edit Prev Buffer    |Go To Next Window   |Edit Next Buffer    |
 Function:                      |Move Cursor Left    |Move Cursor down    |Move Cursor Right   |
 Key:                           |LEFT Arrow          |DOWN Arrow          |RIGHT Arrow         |
                                +--------------------+--------------------+--------------------+
                                
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
map( 'n',       '<F32>',        vim.lsp.buf.code_action,        { desc = 'Use Suggested Fix(es) when Problems are Found' })
map( 'n',       '<F9>',         ':e#<CR>',                      { desc = 'Switch to Most Recent Buffer' })
map( 'n',       '<F21>',        ':split #<CR>',                 { desc = 'Split Screen then Switch to Most Recent Buffer' })
map( 'n',       '<F10>',        ToggleLineNumbers,              { desc = 'Show or Hide Line Numbers' })
map( 'n',       '<F22>',        ToggleSideColumns,              { desc = 'Show or Hide Left Columns for Folds and Indicators' })
map( 'n',       '<F34>',        ToggleCodeCompletion,           { desc = 'Toggle Code Completion Suggestions' })
map( 'n',       '<F11>',        ':buffers<CR>',                 { desc = 'Show All Current Buffers' })
map( 'n',       '<F36>',        ':Lazy home<CR>',               { desc = 'Show Plugin Manager Status' })
--
-- buffers
--
map( 'n',       '<S-Left>',     ':bp<CR>',                      { desc = 'Switch to Previous Buffer' })
map( 'n',       '<S-Right>',    ':bn<CR>',                      { desc = 'Switch to Next Buffer' })
map( 'n',       '<S-Up>',       ':wincmd W<CR>',                { desc = 'Switch to Previous Window' })
map( 'n',       '<S-Down>',     ':wincmd w<CR>',                { desc = 'Switch to Next Window' })
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


