set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after,~/.vim/bundle/Vundle.vim/
set nocompatible
filetype off

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Align'
Plugin 'bufexplorer.zip'
Plugin 'hhvm/vim-hack'
Plugin 'scrooloose/nerdcommenter'
Plugin 'matchit.zip'
Plugin 'juvenn/mustache'
Plugin 'swamplight'
Plugin 'distinguished'
Plugin 'endel/vim-github-colorscheme'
Plugin 'autohotkey-ahk'
Plugin 'ervandew/supertab'
Plugin 'jesseschalken/list-text-object'
Plugin 'Mustang2'
Plugin 'proton'
Plugin 'beauty256'
Plugin 'strange'
Plugin 'elise.vim'
Plugin 'jeetsukumaran/vim-nefertiti'
Plugin 'elisex.vim'
Plugin 'Gentooish'
Plugin 'lettuce.vim'
Plugin 'scite-colors'
Plugin 'Wombat'
Plugin 'wesgibbs/vim-irblack'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'indenthtml.vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomasr/molokai'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Smart-Tabs'
Plugin 'leafgarland/typescript-vim'
Plugin 'dag/vim-fish'
Plugin 'sandeepsinghmails/Dev_Delight'
Plugin 'Junza/Spink'
Plugin 'larssmit/vim-getafe'
Plugin 'nice/sweater'

call vundle#end()

filetype plugin indent on
syntax on

colorscheme github

if has('gui_running')
    set lines=60
    set columns=120
endif

let NERDSpaceDelims=1
let g:solarized_contrast="high"
let g:solarized_visibility="low"
let g:solarized_termcolors=256
let php_folding=1
let php_phpdoc_folding=1
let php_var_selector_is_identifier=1
let php_parent_error_close=1
let php_parent_error_open=1

noremap , ;
noremap ; :
noremap <C-ScrollWheelDown> :tn<CR>
noremap <C-ScrollWheelUp> :tp<CR>
noremap <C-j> :bprev<CR>
noremap <C-k> :bnext<CR>
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
set guicursor=n-v-c:block-Cursor/lCursor,a:blinkwait1000-blinkoff500-blinkon500,i-ci:ver25-Cursor/lCursor,o:hor50-Cursor,r-cr:hor25-Cursor/lCursor,sm:block-Cursor,ve:ver25-Cursor
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
set noautochdir
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
set shiftwidth=4
set showcmd
set showmatch
set showmode
set showtabline=2
set smartindent
set smarttab
set softtabstop=0
set spelllang=en_au,en
set tabstop=4
set tags=./tags;/
set textwidth=78
set ttyfast
set updatetime=1
set wildmenu
set winminheight=0
set winminwidth=0
set wrap
set cursorline

" see http://vim.wikia.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

if has('win32') || has('win64')
    set guifont=Consolas:h10
elseif has('mac')
    set guifont=Menlo:h14
    set guioptions+=e
else
    set guifont=Monospace\ 10
endif

set t_Co=256
