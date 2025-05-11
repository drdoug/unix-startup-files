vim.cmd
        [[
        syntax enable
        colorscheme aurora
        let g:mapleader=","
        ]]

local opt=vim.opt
opt.wrap                =true
opt.ruler               =true
opt.title               =false
opt.number              =true
opt.hidden              =true
opt.wildmenu            =true
opt.undofile            =true
opt.showmode            =true
opt.hlsearch            =false
opt.expandtab           =true
opt.showmatch           =true
opt.mousehide           =true
opt.incsearch           =true
opt.splitright          =true
opt.splitbelow          =true
opt.cursorline          =true
opt.autoindent          =true
opt.breakindent         =true
opt.termguicolors       =true
opt.relativenumber      =true

opt.tabstop             =8
opt.pumblend            =5
opt.cmdheight           =1
opt.scrolloff           =4
opt.matchtime           =8
opt.wrapmargin          =0
opt.laststatus          =2
opt.shiftwidth          =8
opt.showtabline         =2
opt.numberwidth         =6
opt.softtabstop         =8

opt.foldcolumn          ="1"
opt.shortmess           ="I"
opt.belloff             ="all"
opt.signcolumn          ="yes"
opt.wildoptions         ="pum"
opt.formatoptions       ="jnoqr"
opt.cursorlineopt       ="number"
opt.grepprg             ="rg --vimgrep"
opt.grepformat          ="%f:%l:%c:%m"
opt.backspace           ="indent,start"
opt.wildmode            ="longest:full"
opt.switchbuf           ="useopen,uselast"
opt.titlestring         ="%t%r %y %a     (%F)"
opt.cpoptions           ="_aAbBcdeEfFlLmorsStWx$!"
-- opt.statuscolumn        ="%=%{v:relnum?v:relnum:v:lnum}" -- Experimental, not working with foldcolumn or signcolumn
opt.completeopt         ="menu,menuone,noinsert,noselect"
opt.shada               ="'100,f1,<1000,%,h,:100,/100,n~/.config/nvim/saved.shada"

opt.sessionoptions =
        {
        'help',
        'blank',
        'slash',
        'sesdir',
        'resize',
        'winpos',
        'buffers',
        'globals',
        'winsize',
        'options'
        }
opt.guicursor =
        {
        'i-r:ver30-changesCursor',
        'o:hor50-changesCursor-blinkwait100-blinkoff100-blinkon100',
        'c-ci-cr:block-commandCursor'
        }
local get_listed_bufs = function()
        return vim.tbl_filter(
                function( bufnr)
                        return vim.api.nvim_buf_get_option(bufnr, "buflisted")
                end,
        vim.api.nvim_list_bufs()
        )
end

