" took many of these colors from github.com/CosecSecCot/cosec-twilight.nvim.

set bg=dark
hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom'

" Define highlight groups
highlight Normal        guifg=#FEFEFE guibg=#202020
highlight NormalFloat   guifg=#FEFEFE guibg=#202020
highlight Comment       guifg=#6f7b68
highlight TSComment       guifg=#6f7b68
highlight Conceal       guibg=#262626
highlight Constant      guifg=#cccccc
"highlight CursorColumn
"highlight CursorLine
highlight DiffAdd       guifg=#FFFEDB guibg=#2B3328
highlight DiffChange    guifg=#FFFEDB guibg=#262636
highlight DiffDelete    guifg=#C34143 guibg=#42242B
highlight DiffText      guifg=#FFFEDB guibg=#49443C
highlight Directory     guifg=#C1C88D
highlight Error         guifg=#FFFEDB gui=undercurl
highlight ErrorMsg      guifg=#FFFEDB
"highlight FoldColumn
"highlight Folded
highlight Function      guifg=#AA9AAC
highlight Identifier    guifg=#8B9698
"highlight LineNr        guifg=#474A4D
highlight LineNrAbove   guifg=#888888 guibg=#222222
highlight LineNrBelow   guifg=#888888 guibg=#222222
highlight LineNr        guifg=#d6d2c8
highlight MatchParen    guifg=#FFFEDB
highlight NonText       guifg=#303030
highlight Operator      guifg=#DEBF7C
highlight Pmenu         guifg=#918988 guibg=#303030
highlight PmenuSbar     guifg=#918988 guibg=#262626
highlight PmenuSel      guifg=#BFBBBA guibg=#303030
highlight PmenuThumb    guifg=#918988 guibg=#262626 gui=reverse
highlight PreProc       guifg=#8B9698
highlight Question      guifg=#9b8d7f
highlight QuickFixLine  guibg=#303030
highlight Search        guibg=#5F5958
"highlight SignColumn
highlight Special       guifg=#cccccc
highlight SpecialChar   guifg=#C1C88D
highlight SpecialKey    guifg=#676767
highlight Statement     guifg=#cccccc
highlight StatusLine    guifg=#FFFEDB guibg=#34383C
highlight String        guifg=#A2A970
highlight Structure     guifg=#AA9AAC
highlight Substitute    guifg=#1A1A1A guibg=#C1C88D
highlight TabLine       guifg=#A09998 guibg=#212121
highlight TabLineFill   guifg=#A09998 guibg=#212121
highlight TabLineSel    guifg=#A09998 guibg=#40474F
highlight Title         guifg=#FFFEDB term=none cterm=none
highlight Todo          guifg=#8B9698
highlight Type          guifg=#E3D896
highlight Underlined    gui=undercurl
highlight VertSplit     guifg=#303030
highlight Visual        guibg=#454545
highlight WarningMsg    guifg=#FFFEDB
highlight Float         guifg=#6f7b68
highlight Number         guifg=#6f7b68
highlight Boolean         guifg=#6f7b68
highlight WinSeparator         guibg=#111111 guifg=#888888
