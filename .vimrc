set rtp+=~/.opam/system/share/merlin/vim/
set rtp+=~/.vim/bundle/Vundle.vim/
set nocompatible
filetype off

call plug#begin("~/.vim/plugged")

" Plugin 'gmarik/Vundle.vim' " Vundle itself
Plug 'kchmck/vim-coffee-script' " CoffeeScript support
" Plug 'matchit.zip' " % matching for more languages
Plug 'juvenn/mustache' " Mustache template support
" Plug 'autohotkey-ahk' " AutoHotkey script support
Plug 'ervandew/supertab' " Use <Tab> for completion
Plug 'jesseschalken/list-text-object' " More text objects 
Plug 'tpope/vim-fugitive' " Git support
Plug 'tomtom/tcomment_vim' " Use 'gc' to comment/uncomment
Plug 'tomasr/molokai' " Molokai color scheme
Plug 'leafgarland/typescript-vim' " TypeScript support
Plug 'dag/vim-fish' " Fish shell script support
Plug 'hhvm/vim-hack' " Hack lang support

call plug#end()

filetype plugin indent on
syntax on

colorscheme molokai

if has('gui_running')
    set lines=60
    set columns=120
endif

let php_folding=1
let php_phpdoc_folding=1

noremap ; :
noremap , ;
noremap <silent> <Esc><Esc> :nohlsearch<CR>
noremap <space> za
noremap j gj
noremap k gk

set autoindent
set autoread
set autowrite
set backspace=indent,eol,start
set cinoptions=(0,u0,U0,+0,j1,J1
set encoding=utf-8
set fileformats=unix,dos
set foldexpr=min([8,(getline(v:lnum)=~'^\\s*$'?max([indent(v:lnum-1),indent(v:lnum+1)]):indent(v:lnum))/&sw])
set foldlevelstart=99
set foldmethod=syntax
set formatoptions=roq
set grepprg=grep\ -nH\ $*
set guioptions=gia
set hidden
set hlsearch
set incsearch
set indentexpr=
set laststatus=2
set lazyredraw
set linebreak
set listchars=tab:»\ ,trail:·,extends:→,precedes:←
set more
set mouse=a
set mousefocus
set mousemodel=extend
set autochdir
set nocindent
set nocul
set noequalalways
set expandtab
set ignorecase
set nolist
set nonumber
set nosmartcase
set nospell
set noswapfile
set nowrapscan
set number
set ruler
set shell=bash
set shiftwidth=2
set showcmd
set showmatch
set showmode
set showtabline=2
set smartindent
set smarttab
set softtabstop=0
set spelllang=en_au,en
set tabstop=2
set tags=./tags;/
set textwidth=78
set ttyfast
set updatetime=1
set wildmenu
set winminheight=0
set winminwidth=0
set wrap

" see http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if has('win32') || has('win64')
    set guifont=Consolas:h10
elseif has('mac')
    set guifont=Menlo:h12
    set guioptions+=e
else
    set guifont=Monospace\ 10
endif

set t_Co=256
