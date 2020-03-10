" let gg happy with which_key_goto_map on 'g'
let g:which_key_fallback_to_native_key = 1

" normal mappings {{{

" prev and next
let g:which_key_prev_map = {
    \ 'name': '+previous',
    \ 'd':    'diagnostics',
    \ 'g':    'git-chunk',
    \ }

let g:which_key_next_map = {
    \ 'name': '+next',
    \ 'd':    'diagnostics',
    \ 'g':    'git-chunk',
    \ }

" go to
let g:which_key_goto_map = {
    \ 'name': '+goto',
    \ 'd':    'definition',
    \ 'i':    'implementation',
    \ 'r':    'reference',
    \ 't':    'type-definition',
    \ }

" }}}

" mapleader {{{
let g:which_key_global_map = {
    \ 'name': 'Global Operations',
    \ }

let g:which_key_global_map['d'] = {
    \ 'name': '+debug',
    \ 'f':    'fix-current',
    \ 's':    'start-REPL',
    \ }

let g:which_key_global_map['e'] = {
    \ 'name': '+edit',
    \ 'r':    'rename',
    \ 'f':    'format(nv)',
    \ 's':    'strip-tail-space',
    \ }

let g:which_key_global_map['g'] = {
    \ 'name': '+git',
    \ 'd':    'diff',
    \ 'c':    'commit',
    \ }

let g:which_key_global_map['h'] = {
    \ 'name': '+help',
    \ 'v':    'vim',
    \ }

let g:which_key_global_map['l'] = {
    \ 'name': '+list',
    \ 'c':    'coc-commands',
    \ 'd':    'diagnostics',
    \ 'g':    'git-status',
    \ 'o':    'outline',
    \ 'r':    'resume',
    \ 's':    'symbols',
    \ }

let g:which_key_global_map['s'] = {
    \ 'name': '+search',
    \ 'p':    'file-path',
    \ 'm':    'MRU',
    \ 'c':    'content',
    \ 'r':    'content-resume',
    \ 'w':    'under-cursor',
    \ 'f':    'function',
    \ }
" }}}

" maplocalleader {{{
let g:which_key_local_map ={
    \ 'name': 'FileType Operations',
    \ 'c':    'comment-toogle',
    \ }
" }}}

function! s:register_keys(config)
    for [key, dict] in items(a:config)
        call which_key#register(key, dict)
    endfor
endfunction

" ignore tab jump mappings
function! s:ignore_digital_key()
    for i in range(10)
        let g:which_key_global_map[i] = 'which_key_ignore'
    endfor
endfunction

call s:ignore_digital_key()
call s:register_keys({
    \    '<Space>': 'g:which_key_global_map',
    \    ',':       'g:which_key_local_map',
    \    '[':       'g:which_key_prev_map',
    \    ']':       'g:which_key_next_map',
    \    'g':       'g:which_key_goto_map',
    \ })

" vim: set foldmethod=marker:
