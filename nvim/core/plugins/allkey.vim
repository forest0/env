" coc {{{

if dein#tap('coc.nvim')
        " Show all diagnostics
        nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
        " Show commands
        nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
        " Find symbol of current document
        nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
        nnoremap <silent> <leader>lg  :<C-u>CocList --normal gstatus<CR>
        " Do default action for next item.
        " nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
        " Do default action for previous item.
        " nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> <leader>lr  :<C-u>CocListResume<CR>
        " Use `[c` and `]c` for navigate diagnostics
        nmap <silent> ]d <Plug>(coc-diagnostic-prev)
        nmap <silent> [d <Plug>(coc-diagnostic-next)
        " Remap for rename current word
        nmap <leader>er <Plug>(coc-rename)
        " Remap for format selected region
        nmap <silent> <leader>ef <Plug>(coc-format)
        xmap <silent> <leader>ef <Plug>(coc-format-selected)
        " Fix autofix problem of current line
        nmap <leader>df <Plug>(coc-fix-current)

        " a simple REPL implement by custom coc extention
        " nmap <leader>ds <Plug>(coc-repl-sendtext) " wont work
        nnoremap <silent> <leader>ds :<C-u>CocCommand repl.openTerminal<cr>

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gt <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        " Use K for show documentation in preview window
        nnoremap <silent> K :call <sid>show_documentation()<cr>
        " use <c-space> for trigger completion.
        " inoremap <silent><expr> <c-space> coc#refresh()
        nmap [g <Plug>(coc-git-prevchunk)
        nmap ]g <Plug>(coc-git-nextchunk)
        " show chunk diff at current position
        nmap <silent> <leader>gd <Plug>(coc-git-chunkinfo)
        " show commit contains current position
        nmap <silent> <leader>gm <Plug>(coc-git-commit)
        " float window scroll
        " nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
        " nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"
        " multiple cursors session
        " nmap <silent> <C-c> <Plug>(coc-cursors-position)
        " nmap <silent> <C-m> <Plug>(coc-cursors-word)
        " xmap <silent> <C-m> <Plug>(coc-cursors-range)
        " use normal command like `<leader>xi(`
        " nmap <leader>x  <Plug>(coc-cursors-operator)

        " Use <C-j> for select text for visual placeholder of snippet.
        vmap <C-j> <Plug>(coc-snippets-select)

        " Use tab for trigger completion with characters ahead and navigate
        inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <C-j> for both expand and jump (make expand higher priority.)
        imap <C-j> <Plug>(coc-snippets-expand-jump)


        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                try
                    execute 'h '.expand('<cword>')
                catch /E149/
                    echohl WarningMsg
                    echon 'No doc found for: ' expand('<cword>')
                    echohl None
                endtry
            else
                call CocAction('doHover')
                endif
        endfunction
endif

" }}}

" choosewin {{{

if dein#tap('vim-choosewin')
    nmap - <Plug>(choosewin)
endif

" }}}

" quickrun {{{

" if dein#tap('vim-quickrun')
"     nnoremap <silent> <localleader>r :QuickRun<CR>
" endif

" }}}

" nerdcommenter {{{

if dein#tap('nerdcommenter')
    xmap <silent> <localleader>c <Plug>NERDCommenterToggle
    nmap <silent> <localleader>c <Plug>NERDCommenterToggle
endif

" }}}

" LeaderF {{{

if dein#tap('LeaderF')
    nnoremap <leader>sp :LeaderfFile<cr>
    nnoremap <leader>sm :LeaderfMru<cr>
    nnoremap <leader>sc :LeaderfRgInteractive<cr>
    nnoremap <leader>sr :LeaderfRgRecall<cr>
    nnoremap <leader>sf :LeaderfFunction<cr>
    nnoremap <leader>sl :LeaderfLineAll<cr>

    nnoremap <leader>hv :LeaderfHelp<cr>
    nnoremap <silent> / :Leaderf line --stayOpen<cr>
    nnoremap <silent> * :Leaderf line --cword --stayOpen<cr>
    nnoremap <silent> ! :Leaderf cmdHistory --popup<cr>
endif

" }}}

" defx {{{

if dein#tap('defx.nvim')
    nnoremap <F2> :Defx<CR>
endif

" }}}

" whichkey {{{

if dein#tap('vim-which-key')
    nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
    nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
    nnoremap <silent> [ :<c-u>WhichKey  '['<CR>
    nnoremap <silent> ] :<c-u>WhichKey  ']'<CR>
    nnoremap <silent> g :<c-u>WhichKey  'g'<CR>
endif

" }}}

" easy-align {{{

if dein#tap('vim-easy-align')
    xmap a <Plug>(EasyAlign)
endif

" }}}

" eaysmotion {{{

if dein#tap('vim-easymotion')
    nmap f <Plug>(easymotion-overwin-f)
endif

" }}}

if dein#tap('vim-markdown')
    autocmd FileType markdown nmap [h <Plug>Markdown_MoveToPreviousHeader
    autocmd FileType markdown nmap ]h <Plug>Markdown_MoveToNextHeader
endif


" vim: set foldmethod=marker:
