let g:Lf_HideHelp = 1
let g:Lf_CursorBlink = 0
let g:Lf_StlColorscheme = 'gruvbox_material'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WindowHeight = 0.25
let g:Lf_PreviewResult = {
    \ 'File': 0,
    \ 'Buffer': 0,
    \ 'Mru': 0,
    \ 'Tag': 0,
    \ 'BufTag': 1,
    \ 'Function': 1,
    \ 'Line': 1,
    \ 'Colorscheme': 0,
    \ 'Rg': 1,
    \ 'Gtags': 0
    \ }

" disable default mapping
let g:Lf_ShortcutF = ""
let g:Lf_ShortcutB = ""

" FIXME: 2020-03-08
" dont use popup becase of highlighting bug in pop-up window
" let g:Lf_WindowPosition = 'popup'
" let g:Lf_PreviewInPopup = 1
" let g:Lf_PopupColorscheme = 'default'

highlight def Lf_hl_match  gui=bold guifg=#cb4239 cterm=bold ctermfg=48
highlight def Lf_hl_match0 gui=bold guifg=#cb4239 cterm=bold ctermfg=48
highlight def Lf_hl_cursorline guibg=#010101 ctermfg=226
