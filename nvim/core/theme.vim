" enable 256 color terminal
set t_Co=256

" enable true color
if has('termguicolors')
    set termguicolors
endif

set background=dark

colorscheme  solarized8_flat


" vim {{{

hi Whitespace ctermfg=96 guifg=#725972 guibg=NONE ctermbg=NONE
hi VertSplit  ctermfg=Black  guifg=Black
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermfg=187 ctermbg=NONE guifg=#ebdbb2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#002931

" }}}

" pmenu {{{

highlight PMenuSel ctermfg=252 ctermbg=106 guifg=#d0d0d0 guibg=#859900 guisp=#859900 cterm=NONE gui=NONE

" }}}

" coc {{{

hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
hi default CocHighlightText  guibg=#725972 ctermbg=96
hi CocWarningSign  ctermfg=32 ctermbg=NONE guifg=#0087d7 guibg=NONE

" }}}

" gitgutter coc-git {{{

" current color cannot be seen clearly, may be configured later

highlight GitGutterAdd ctermfg=22 guifg=#89972e ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermfg=58 guifg=#af8a2d ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE

" }}}

" defx {{{

highlight Defx_filename_3_Modified  ctermfg=1  guifg=#D370A3
highlight Defx_filename_3_Staged    ctermfg=10 guifg=#A3D572
highlight Defx_filename_3_Ignored   ctermfg=8  guifg=#404660
highlight def link Defx_filename_3_Untracked Comment
highlight def link Defx_filename_3_Unknown Comment
highlight def link Defx_filename_3_Renamed Title
highlight def link Defx_filename_3_Unmerged Label
highlight Defx_git_Deleted   ctermfg=13 guifg=#b294bb

" }}}

" buftabline {{{

highlight BufTabLineCurrent ctermbg=96 guibg=#5d4d7a

" }}}

" vim: set foldmethod=marker:
