"
" [ngm]vim colors
"
" named Aurora after the colors of the Northern Lights
" yes, it could be a bit more imaginitive...
"

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="aurora"

hi Boolean         guifg=coral
hi Character       guifg=coral2
hi ColorColumn                            guibg=gray15
hi Comment         guifg=yellow2
hi Conditional     guifg=magenta                               gui=bold
hi Constant        guifg=tomato3                               gui=bold
hi Cursor                                 guibg=khaki
hi   ChangesCursor                        guibg=red
hi   CommandCursor                        guibg=hotpink
hi CursorColumn                           guibg=gray25
hi CursorLine                             guibg=gray15
hi CursorLineNr    guifg=white                                 gui=none
hi Debug           guifg=maroon                                gui=bold
hi Define          guifg=skyblue
hi Delimiter       guifg=gray56
hi DiffAdd                                guibg=darkslategray
hi DiffChange                             guibg=darkslategray
hi DiffDelete      guifg=darkslategray4   guibg=darkslategray
hi DiffText        guifg=yellow           guibg=darkslategray  gui=bold,underline
hi Directory       guifg=yellowgreen                           gui=bold
hi Error           guifg=yellow           guibg=darkred
hi ErrorMsg        guifg=coral            guibg=gray27
hi Exception       guifg=coral2                                gui=bold
hi Float           guifg=tomato3
hi FoldColumn      guifg=gray52           guibg=black
hi Folded          guifg=gray52           guibg=black
hi Function        guifg=greenyellow
hi Identifier      guifg=darkorange
hi Ignore          guifg=gray54           guibg=bg
hi IncSearch       guifg=khaki            guibg=black
hi Keyword         guifg=salmon                                gui=bold
hi Label           guifg=lightgoldenrod2                       gui=none
hi LineNr          guifg=green4           guibg=gray15
hi Macro           guifg=skyblue                               gui=italic
hi MatchParen      guifg=yellow3          guibg=gray35         gui=bold
hi Menu            guifg=white            guibg=gray40
hi ModeMsg         guifg=palegreen
hi MoreMsg         guifg=palegreen
hi NonText         guifg=DarkSlateBlue
hi Normal          guifg=ivory1           guibg=gray8
hi Number          guifg=coral
hi Operator        guifg=deeppink
hi Pmenu           guifg=skyblue1         guibg=black
hi PmenuSbar                              guibg=gray5
hi PmenuSel                               guibg=gray70
hi PmenuThumb      guifg=skyblue1
hi PreCondit       guifg=lightskyblue                          gui=bold
hi PreProc         guifg=deepskyblue                           gui=italic
hi Question        guifg=deepskyblue
hi Repeat          guifg=deeppink                              gui=bold
hi Search          guifg=black            guibg=gold
hi Scrollbar       guifg=gray80           guibg=gray20
hi SignColumn      guifg=chartreuse1      guibg=gray30
hi Special         guifg=turquoise1       guibg=bg             gui=italic
hi SpecialChar     guifg=maroon2                               gui=bold
hi SpecialComment  guifg=gray70                                gui=bold
hi SpecialKey      guifg=DarkSlateBlue
hi SpecialKey      guifg=turquoise1                            gui=italic
hi Statement       guifg=maroon3                               gui=bold
hi StatusLine      guifg=blue             guibg=cornsilk
hi StatusLineNC    guifg=skyblue          guibg=tan
hi StorageClass    guifg=greenyellow                           gui=italic
hi String          guifg=palegreen
hi Structure       guifg=magenta3
hi TabLine         guifg=gray70           guibg=gray10         gui=none
hi TabLineFill     guifg=gray10           guibg=gray70
hi Tag             guifg=maroon3                               gui=italic
hi Title           guifg=orangered2
hi Todo            guifg=red              guibg=bg             gui=italic,bold
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
hi WildMenu        guifg=turquoise1       guibg=black
hi iCursor         guifg=black            guibg=oldlace
if has("spell")
    hi SpellBad    guisp=#FF0000                           gui=undercurl
    hi SpellCap    guisp=#7070F0                           gui=undercurl
    hi SpellLocal  guisp=#70F0F0                           gui=undercurl
    hi SpellRare   guisp=#FFFFFF                           gui=undercurl
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
"   hi Normal       ctermfg=252 ctermbg=233
"   hi CursorLine               ctermbg=234   cterm=none
"   hi CursorLineNr ctermfg=208               cterm=none
"   hi Boolean         ctermfg=135
"   hi Character       ctermfg=144
"   hi Number          ctermfg=135
"   hi String          ctermfg=144
"   hi Conditional     ctermfg=161               cterm=bold
"   hi Constant        ctermfg=135               cterm=bold
"   hi Cursor          ctermfg=16  ctermbg=253
"   hi Debug           ctermfg=225               cterm=bold
"   hi Define          ctermfg=81
"   hi Delimiter       ctermfg=241
"
"   hi DiffAdd                     ctermbg=24
"   hi DiffChange      ctermfg=181 ctermbg=239
"   hi DiffDelete      ctermfg=162 ctermbg=53
"   hi DiffText                    ctermbg=102 cterm=bold
"
"   hi Directory       ctermfg=118               cterm=bold
"   hi Error           ctermfg=219 ctermbg=89
"   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
"   hi Exception       ctermfg=118               cterm=bold
"   hi Float           ctermfg=135
"   hi FoldColumn      ctermfg=67  ctermbg=16
"   hi Folded          ctermfg=67  ctermbg=16
"   hi Function        ctermfg=118
"   hi Identifier      ctermfg=208               cterm=none
"   hi Ignore          ctermfg=244 ctermbg=232
"   hi IncSearch       ctermfg=193 ctermbg=16
"
"   hi keyword         ctermfg=161               cterm=bold
"   hi Label           ctermfg=229               cterm=none
"   hi Macro           ctermfg=193
"   hi SpecialKey      ctermfg=81
"
"   hi MatchParen      ctermfg=233  ctermbg=208 cterm=bold
"   hi ModeMsg         ctermfg=229
"   hi MoreMsg         ctermfg=229
"   hi Operator        ctermfg=161
"
"   " complete menu
"   hi Pmenu           ctermfg=81  ctermbg=16
"   hi PmenuSel        ctermfg=255 ctermbg=242
"   hi PmenuSbar                   ctermbg=232
"   hi PmenuThumb      ctermfg=81
"
"   hi PreCondit       ctermfg=118               cterm=bold
"   hi PreProc         ctermfg=118
"   hi Question        ctermfg=81
"   hi Repeat          ctermfg=161               cterm=bold
"   hi Search          ctermfg=0   ctermbg=222   cterm=NONE
"
"   " marks column
"   hi SignColumn      ctermfg=118 ctermbg=235
"   hi SpecialChar     ctermfg=161               cterm=bold
"   hi SpecialComment  ctermfg=245               cterm=bold
"   hi Special         ctermfg=81
"   if has("spell")
"       hi SpellBad                ctermbg=52
"       hi SpellCap                ctermbg=17
"       hi SpellLocal              ctermbg=17
"       hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
"   endif
"   hi Statement       ctermfg=161               cterm=bold
"   hi StatusLine      ctermfg=238 ctermbg=253
"   hi StatusLineNC    ctermfg=244 ctermbg=232
"   hi StorageClass    ctermfg=208
"   hi Structure       ctermfg=81
"   hi Tag             ctermfg=161
"   hi Title           ctermfg=166
"   hi Todo            ctermfg=231 ctermbg=232   cterm=bold
"
"   hi Typedef         ctermfg=81
"   hi Type            ctermfg=81                cterm=none
"   hi Underlined      ctermfg=244               cterm=underline
"
"   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
"   hi VisualNOS                   ctermbg=238
"   hi Visual                      ctermbg=235
"   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
"   hi WildMenu        ctermfg=81  ctermbg=16
"
"   hi Comment         ctermfg=59
"   hi CursorColumn                ctermbg=236
"   hi ColorColumn                 ctermbg=236
"   hi LineNr          ctermfg=250 ctermbg=236
"   hi NonText         ctermfg=59
"
"   hi SpecialKey      ctermfg=59
"
"   if exists("g:rehash256") && g:rehash256 == 1
"       hi Normal       ctermfg=252 ctermbg=234
"       hi CursorLine               ctermbg=236   cterm=none
"       hi CursorLineNr ctermfg=208               cterm=none
"
"       hi Boolean         ctermfg=141
"       hi Character       ctermfg=222
"       hi Number          ctermfg=141
"       hi String          ctermfg=222
"       hi Conditional     ctermfg=197               cterm=bold
"       hi Constant        ctermfg=141               cterm=bold
"
"       hi DiffDelete      ctermfg=125 ctermbg=233
"
"       hi Directory       ctermfg=154               cterm=bold
"       hi Error           ctermfg=222 ctermbg=233
"       hi Exception       ctermfg=154               cterm=bold
"       hi Float           ctermfg=141
"       hi Function        ctermfg=154
"       hi Identifier      ctermfg=208
"
"       hi Keyword         ctermfg=197               cterm=bold
"       hi Operator        ctermfg=197
"       hi PreCondit       ctermfg=154               cterm=bold
"       hi PreProc         ctermfg=154
"       hi Repeat          ctermfg=197               cterm=bold
"
"       hi Statement       ctermfg=197               cterm=bold
"       hi Tag             ctermfg=197
"       hi Title           ctermfg=203
"       hi Visual                      ctermbg=238
"
"       hi Comment         ctermfg=244
"       hi LineNr          ctermfg=239 ctermbg=235
"       hi NonText         ctermfg=239
"       hi SpecialKey      ctermfg=239
"   endif
"end

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
