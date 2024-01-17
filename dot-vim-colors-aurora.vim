"
" [ngm]vim colors
"
" named Aurora after the colors of the Northern Lights
" yes, I could be aa bit more imaginitive...
"

hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="aurora"

hi Boolean         guifg=coral
hi Character       guifg=coral2
hi ColorColumn                   guibg=gray15
hi Comment         guifg=yellow
hi Conditional     guifg=magenta               gui=bold
hi Constant        guifg=tomato3               gui=bold
hi Cursor                        guibg=khaki
hi   ChangesCursor               guibg=red
hi   CommandCursor               guibg=hotpink
hi CursorColumn                  guibg=gray25
hi CursorLine                    guibg=bg
hi CursorLineNr    guifg=dodgerblue            gui=none
hi Debug           guifg=maroon                gui=bold
hi Define          guifg=skyblue
hi Delimiter       guifg=gray56
hi DiffAdd                       guibg=darkslategray
hi DiffChange                    guibg=darkslategray
hi DiffDelete      guifg=darkslategray4 guibg=darkslategray
hi DiffText        guifg=yellow  guibg=darkslategray gui=bold,underline
hi Directory       guifg=yellowgreen           gui=bold
hi Error           guifg=#E6DB74 guibg=#1E0010
hi ErrorMsg        guifg=coral   guibg=#232526
hi Exception       guifg=coral2                gui=bold
hi Float           guifg=tomato3
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000
hi Keyword         guifg=salmon                gui=bold
hi Label           guifg=#E6DB74               gui=none
hi LineNr          guifg=#465457 guibg=#232526
hi Macro           guifg=skyblue               gui=italic
hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi Menu            guifg=white   guibg=gray40
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi NonText         guifg=#465457
hi Normal          guifg=#F8F8F2 guibg=#060606
hi Number          guifg=coral
hi Operator        guifg=#F92672
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSbar                     guibg=#080808
hi PmenuSel                      guibg=#808080
hi PmenuThumb      guifg=#66D9EF
hi PreCondit       guifg=lightskyblue          gui=bold
hi PreProc         guifg=deepskyblue           gui=italic
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
hi Scrollbar       guifg=gray80  guibg=gray20
hi SignColumn      guifg=#A6E22E guibg=#232526
hi Special         guifg=#66D9EF guibg=bg      gui=italic
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
hi SpecialKey      guifg=#465457
hi SpecialKey      guifg=#66D9EF               gui=italic
hi Statement       guifg=maroon3               gui=bold
hi StatusLine      guifg=blue    guibg=cornsilk
hi StatusLineNC    guifg=skyblue guibg=tan
hi StorageClass    guifg=greenyellow           gui=italic
hi String          guifg=palegreen
hi Structure       guifg=magenta3
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none
hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FF0000 guibg=bg      gui=italic,bold
hi Type            guifg=green                 gui=none
hi Typedef         guifg=#66D9EF
hi Underlined      guifg=#808080               gui=underline
hi User1           guifg=white   guibg=blue    gui=none
hi User2           guifg=red     guibg=blue    gui=bold
hi User3           guifg=gray70  guibg=blue    gui=none
hi User4           guifg=gold    guibg=blue    gui=none
hi User5           guifg=gray40  guibg=blue    gui=none
hi User6           guifg=gray30  guibg=tan     gui=none
hi User7           guifg=gray20  guibg=blue    gui=none
hi User8           guifg=gray18  guibg=red     gui=none
hi User9           guifg=gray15  guibg=red     gui=none
hi VertSplit       guifg=wheat   guibg=tan     gui=bold
hi Visual          guifg=gold    guibg=gray30
hi VisualNOS       guifg=yellow  guibg=midnightblue
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000
hi iCursor         guifg=#000000 guibg=#F8F8F0
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
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
