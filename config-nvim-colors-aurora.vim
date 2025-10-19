"
" [ngm]vim colors
"
" named Aurora after the colors of the Northern Lights
" yes, it could be a bit more imaginitive...
"
" Use lower-case names found at https://color-hex.org/names
"

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="aurora"

        hi      AerialFunctionIcon        guifg=yellow guibg=NONE guisp=NONE gui=NONE cterm=NONE
        hi      AerialLineNC              guibg=Gray
        hi      AerialGuide1              guifg=Red
        hi      AerialGuide2              guifg=Blue
        hi link AerialClass               Type
        hi link AerialClassIcon           Function
        hi link AerialFunction            VisualNOS
        hi link AerialNormal              Normal
        hi link AerialLine                Menu
        hi link AerialGuide               Comment

hi Normal          guifg=ivory            guibg=gray4

hi Boolean         guifg=mediumspringgreen
hi Character       guifg=coral2
hi ColorColumn                            guibg=gray15
hi Comment         guifg=yellow2
hi Conceal         guifg=white            guibg=gray4  " unused...
hi Conditional     guifg=magenta                               gui=bold
hi Constant        guifg=yellowgreen                           gui=bold
hi Cursor                                 guibg=khaki
hi   ChangesCursor                        guibg=red
hi   CommandCursor                        guibg=hotpink
hi CursorColumn                           guibg=gray25
hi CursorLine      guifg=yellow           guibg=gray14
hi CursorLineNr    guifg=greenyellow      guibg=gray15         gui=none
hi Debug           guifg=maroon                                gui=bold
hi Define          guifg=skyblue
hi Delimiter       guifg=gray56
hi DiagnosticError guifg=red              guibg=gray14
hi DiagnosticHint  guifg=skyblue          guibg=gray14
hi DiagnosticInfo  guifg=green            guibg=gray14
hi DiagnosticWarn  guifg=gold             guibg=gray14
hi DiffAdd                                guibg=darkslategray
hi DiffChange                             guibg=darkslategray
hi DiffDelete      guifg=darkslategray4   guibg=darkslategray
hi DiffText        guifg=yellow           guibg=darkslategray  gui=bold,underline
hi Directory       guifg=yellowgreen                           gui=bold
hi EndOfBuffer     guifg=white            guibg=gray4  " unused...
hi Error           guifg=yellow           guibg=darkred
hi ErrorMsg        guifg=coral            guibg=gray27
hi Exception       guifg=coral2                                gui=bold
hi Float           guifg=tomato3
hi FoldColumn      guifg=gray52           guibg=gray14
hi Folded          guifg=gray52           guibg=black
hi Function        guifg=burlywood3
hi Identifier      guifg=burlywood1
hi Ignore          guifg=gray54           guibg=bg
hi IncSearch       guifg=khaki            guibg=black
hi Keyword         guifg=moccasin                              gui=bold
hi Label           guifg=lightgoldenrod2                       gui=none
hi LineNr          guifg=green4           guibg=gray14
hi Macro           guifg=skyblue                               gui=italic
hi MatchParen      guifg=yellow3          guibg=gray35         gui=bold
hi Menu            guifg=orange           guibg=gray40
hi ModeMsg         guifg=palegreen
hi MoreMsg         guifg=palegreen
hi MsgArea         guifg=white            guibg=gray4  " unused...
hi MsgSeparator    guifg=white            guibg=gray4  " unused...
hi NonText         guifg=grey45
hi NormalFloat                            guibg=gray16
hi FloatBorder     guifg=white            guibg=grey16
hi Number          guifg=limegreen
hi Operator        guifg=thistle
hi PMenu                                  guibg=gray14
hi PMenuSel        guifg=DarkSlateBlue    guibg=white
hi PMenuSbar       guifg=gold             guibg=gray5
hi PMenuThumb      guifg=darkblue
hi PmenuExtra      guifg=blue
hi PreCondit       guifg=lightskyblue                          gui=bold
hi PreProc         guifg=deepskyblue                           gui=bold
hi Question        guifg=deepskyblue
hi QuickFixLine    guifg=white            guibg=gray4  " unused...
hi Repeat          guifg=deeppink                              gui=bold
hi Search          guifg=black            guibg=gold
hi Scrollbar       guifg=gray80           guibg=gray20
hi SignColumn      guifg=chartreuse1      guibg=gray14
hi SnippetTabstop  guifg=white            guibg=gray4  " unused...
hi Special         guifg=maroon3                               gui=bold
hi SpecialChar     guifg=maroon2                               gui=bold
hi SpecialComment  guifg=gray70                                gui=bold
hi SpecialKey      guifg=DarkSlateBlue
hi SpecialKey      guifg=turquoise1                            gui=italic
hi Statement       guifg=maroon3                               gui=bold
hi StatusLine      guifg=blue             guibg=grey20
hi StatusLineNC    guifg=skyblue          guibg=tan
hi StorageClass    guifg=greenyellow                           gui=italic
hi String          guifg=palegreen
hi Structure       guifg=magenta3
hi Substitute      guifg=white            guibg=gray4  " unused...
hi TabLine         guifg=gray70           guibg=gray10         gui=none
hi TabLineFill     guifg=gray10           guibg=gray70
hi Tag             guifg=maroon3                               gui=italic
hi Title           guifg=orangered2
hi Todo            guifg=orange           guibg=bg             gui=italic,bold
hi Type            guifg=orchid                                gui=none
hi Typedef         guifg=turquoise1
hi Underlined      guifg=gray80                                gui=underline
hi User1           guifg=white            guibg=blue           gui=none
hi User2           guifg=red              guibg=blue           gui=bold
hi User3           guifg=gray70           guibg=blue           gui=none
hi User4           guifg=gold             guibg=blue           gui=none
hi User5           guifg=gray40           guibg=blue           gui=none
hi User6           guifg=gray30           guibg=tan            gui=none
hi User7           guifg=gray20           guibg=blue           gui=none
hi User8           guifg=gray18           guibg=red            gui=none
hi User9           guifg=gray15           guibg=red            gui=none
hi VertSplit       guifg=wheat            guibg=tan            gui=bold
hi Visual          guifg=gold             guibg=gray30
hi VisualNOS       guifg=yellow           guibg=midnightblue
hi WarningMsg      guifg=yellow           guibg=gray9          gui=bold
hi Whitespace      guifg=white            guibg=gray4  " unused...
hi WildMenu        guifg=turquoise1       guibg=black
hi WinBar          guifg=white            guibg=gray4  " unused...
hi WinBarNC        guifg=white            guibg=gray4  " unused...
hi WinSeparator    guifg=white            guibg=gray4  " unused...
hi iCursor         guifg=black            guibg=oldlace
if has("spell")
    hi SpellBad    guisp=#FF0000                               gui=undercurl
    hi SpellCap    guisp=#7070F0                               gui=undercurl
    hi SpellLocal  guisp=#70F0F0                               gui=undercurl
    hi SpellRare   guisp=#FFFFFF                               gui=undercurl
endif

"
" Support for 256-color terminal
"
if &t_Co > 255
        hi Normal              ctermfg=white      ctermbg=black              cterm=none        
                                                                             
        hi Comment             ctermfg=yellow     ctermbg=black              cterm=none        
        hi Constant            ctermfg=green      ctermbg=black              cterm=none        
        hi   String            ctermfg=green      ctermbg=black              cterm=none        
        hi   Character         ctermfg=green      ctermbg=black              cterm=none        
        hi Error               ctermfg=red        ctermbg=black              cterm=none        
        hi Identifier          ctermfg=magenta    ctermbg=black              cterm=none        
        hi   Function          ctermfg=lightblue  ctermbg=black              cterm=none        
        hi Statement           ctermfg=green      ctermbg=black              cterm=none        
        hi PreProc             ctermfg=blue       ctermbg=black              cterm=none        
        hi Type                ctermfg=green      ctermbg=black              cterm=none        
        hi Special             ctermfg=blue       ctermbg=black              cterm=none        
        hi   Tag               ctermfg=lightblue  ctermbg=black              cterm=underline   
        hi Todo                ctermfg=red        ctermbg=black              cterm=bold        
        hi Folded              ctermfg=blue       ctermbg=black              cterm=bold        
        hi FoldColumn          ctermfg=blue       ctermbg=black              cterm=bold        
        hi cIf0                ctermfg=blue       ctermbg=black              cterm=underline   
                                                                             
        hi Cursor              ctermfg=black      ctermbg=yellow             cterm=none        
        hi   ChangesCursor     ctermfg=lightgreen ctermbg=red                cterm=none        
        hi   CommandCursor     ctermfg=black      ctermbg=darkred            cterm=none        
                                                                             
        hi DiffChange          ctermfg=darkyellow ctermbg=gray               cterm=none        
        hi DiffText            ctermfg=red        ctermbg=gray               cterm=underline   
        hi DiffAdd             ctermfg=yellow     ctermbg=gray               cterm=none        
        hi DiffDelete          ctermfg=darkred    ctermbg=gray               cterm=none        
                                                                             
        hi Directory           ctermfg=lightgreen ctermbg=black              cterm=none        
        hi ErrorMsg            ctermfg=white      ctermbg=darkred            cterm=none        
        hi IncSearch           ctermfg=black      ctermbg=yellow             cterm=bold        
        hi LineNr              ctermfg=red        ctermbg=black              cterm=none        
        hi Menu                ctermfg=white      ctermbg=lightblue          cterm=none        
        hi MoreMsg             ctermfg=white      ctermbg=blue               cterm=bold        
        hi ModeMsg             ctermfg=cyan       ctermbg=blue               cterm=none        
        hi NonText             ctermfg=lightgreen ctermbg=black              cterm=none        
        hi Pmenu               ctermfg=lightgreen ctermbg=darkblue
        hi PmenuSbar                              ctermbg=darkblue
        hi PmenuSel blend=0                       ctermbg=darkblue
        hi PmenuThumb          ctermfg=cyan
        hi Question            ctermfg=white      ctermbg=lightblue          cterm=bold        
        hi Scrollbar           ctermfg=white      ctermbg=lightblue          cterm=none        
        hi Search              ctermfg=yellow     ctermbg=blue               cterm=italic      
        hi SpecialKey          ctermfg=white      ctermbg=black              cterm=none        
        hi StatusLine          ctermfg=yellow     ctermbg=darkgray           cterm=none        
        hi StatusLineNC        ctermfg=yellow     ctermbg=darkgray           cterm=none        
        hi Title               ctermfg=white      ctermbg=black              cterm=none        
        hi Visual              ctermfg=yellow     ctermbg=gray               cterm=none        
        hi WarningMsg          ctermfg=red        ctermbg=darkgray           cterm=none        
        hi User1               ctermfg=white      ctermbg=darkblue               cterm=none        
        hi User2               ctermfg=red        ctermbg=darkblue               cterm=bold        
        hi User3               ctermfg=yellow     ctermbg=darkblue               cterm=none        
        hi User4               ctermfg=darkyellow ctermbg=darkblue               cterm=none
        hi User5               ctermfg=darkgray   ctermbg=darkblue               cterm=none
                                                                             
        hi HtmlLink            ctermfg=yellow     ctermbg=darkBlue           cterm=underline   
        hi HtmlBold              cterm=bold
        hi HtmlBoldUnderline     cterm=bold,underline
        hi HtmlBoldItalic        cterm=bold,italic
        hi HtmlBoldUnderlineItalic cterm=bold,italic,underline
        hi HtmlUnderline         cterm=underline
        hi HtmlUnderlineItalic   cterm=italic,underline
        hi HtmlItalic            cterm=italic

endif

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
