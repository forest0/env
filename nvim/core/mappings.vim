" :verbose imap xx
" above command can be used to check the last time where xx mapping is defined


" insert {{{

" elegent like playing piano, huh?
inoremap jk <esc>

" }}}

" normal {{{

" swap ; and :
nnoremap ; :
nnoremap : ;

" delete to current line ending
nnoremap D d$

" remove spaces at the end of lines
nnoremap <silent> <leader>es :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

function! s:map_tabline()
    let l:cnt = 1
    while l:cnt < 10
        exec "nmap <leader>" . l:cnt . " <Plug>BufTabLine.Go(" . (l:cnt) .")"
        let l:cnt = l:cnt + 1
    endwhile
endfunction

call s:map_tabline()

" }}}

" visual {{{

xmap <silent> <TAB> <Plug>(coc-repl-sendtext)

" }}}

" terminal {{{
tnoremap jk <C-\><C-n>
" }}}

" vim: set foldmethod=marker:
