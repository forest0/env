" spaceline depends on the following two variables to render statusline
" FIXME: make '⚠' as the warning sign, but there is overlap problem
let g:coc_status_error_sign = '✗'
let g:coc_status_warning_sign = '∆'

let g:coc_global_extensions = [
    \ 'coc-git',
    \ 'coc-snippets',
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-highlight',
    \ 'coc-lists',
    \ 'coc-tabnine',
    \ 'coc-dictionary',
    \ ]

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Disable auto pair for ' when edit lisp
autocmd FileType lisp,scheme let b:coc_pairs_disabled = ["'"]
