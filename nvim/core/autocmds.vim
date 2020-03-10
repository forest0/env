" reload vim config automatically
execute 'autocmd MyAutoCmd BufWritePost '.$VIMPATH.'/core/*,vimrc nested'
    \ .' source $MYVIMRC | redraw | silent doautocmd ColorScheme'

augroup MyAutoCmd
    autocmd WinEnter,InsertLeave * set cursorline

    autocmd WinLeave,InsertEnter * set nocursorline

    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

    autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END
