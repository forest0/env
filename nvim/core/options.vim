set nobackup
set nowritebackup
set noswapfile
set autoread
set autowrite
set confirm
set splitbelow
set bsdir=buffer
if has('vim_starting')
    set encoding=UTF-8
    set fileencodings=utf-8,gb18030
    scriptencoding UTF-8
endif
set laststatus=2
set showtabline=2
set statusline=-        " hide file name in statusline
set fillchars+=vert:\|  " add a bar for vertical splits

" clipboard {{{

if has('unix')
    if has('mac')
        let g:clipboard = {
            \   'name': 'macOS-clipboard',
            \   'copy': {
            \      '+': 'pbcopy',
            \      '*': 'pbcopy',
            \    },
            \   'paste': {
            \      '+': 'pbpaste',
            \      '*': 'pbpaste',
            \   },
            \   'cache_enabled': 0,
            \ }
    else
        " FIXME: 2020-04-25
        " neovim 0.4.3 can not handle escape sequence properly,
        " so the following wont work
        let g:clipboard = {
            \   'name': 'Linux-clipboard',
            \   'copy': {
            \      '+': expand('~/.iterm2/it2copy'),
            \      '*': expand('~/.iterm2/it2copy'),,
            \    },
            \   'paste': {
            \      '+': '+',
            \      '*': '*',
            \   },
            \   'cache_enabled': 0,
            \ }
    endif
endif

if has('clipboard')
    set clipboard& clipboard+=unnamedplus
endif

" }}}


set history=2000
set number
set timeout ttimeout
set cmdheight=2         " Height of the command line
set timeoutlen=500
set ttimeoutlen=10
set updatetime=300
set undofile
set undodir=~/.tmp/undo
set relativenumber
set backspace=2
set backspace=indent,eol,start

" tab and indent {{{

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set shiftround

" }}}

set hidden
set shortmess=aFc
set signcolumn=yes
set completefunc=emoji#complete
set completeopt =longest,menu
set completeopt-=preview
set list
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←

set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set hlsearch        " Highlight search results
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
set grepprg=rg\ --vimgrep\ $*
set wildignore+=*.so,*~,*/.git/*,*/.svn/*,*/.DS_Store,*/tmp/*

set conceallevel=0 concealcursor=niv

" restore cursor style after neovim exit
" FIXME: 2020-03-08, bug still here?
" See: https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
au VimLeave * set guicursor=a:block-blinkon0

" vim: set foldmethod=marker:
