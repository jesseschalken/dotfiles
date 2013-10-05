
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	set guifont=Consolas:h12:b
	set guioptions=gi
elseif has('mac')
	set guifont=Menlo:h14
	set guioptions=gie
else
	set guifont=Monospace\ 10
	set guioptions=gi
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Align'
Bundle 'bufexplorer.zip'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'matchit.zip'
Bundle 'juvenn/mustache'
" Bundle 'StanAngeloff/php.vim'
Bundle 'autohotkey-ahk'
Bundle 'nerdtree'
Bundle 'ervandew/supertab'
Bundle 'jesseschalken/list-text-object'
Bundle 'Mustang2'
Bundle 'elise.vim'
Bundle 'elisex.vim'
Bundle 'Gentooish'
Bundle 'lettuce.vim'
Bundle 'scite-colors'
Bundle 'Wombat'
Bundle 'wesgibbs/vim-irblack'
Bundle 'noahfrederick/vim-hemisu'
Bundle 'indenthtml.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'molokai'
Bundle 'jellybeans.vim'

filetype plugin indent on

if has('gui_running')
	colorscheme ir_black
	set lines=60
	set columns=120
else
	set background=dark
endif

let NERDSpaceDelims=1
let g:solarized_contrast="high"
let g:solarized_visibility="low"
let php_folding=1
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
set encoding=utf-8
set errorformat=%m\ in\ %f\ on\ line\ %l
set fileformats=unix,dos
set foldexpr=min([8,(getline(v:lnum)=~'^\\s*$'?max([indent(v:lnum-1),indent(v:lnum+1)]):indent(v:lnum))/&sw])
set foldmethod=syntax
set foldlevelstart=99
set formatoptions=tcqroa
set grepprg=grep\ -nH\ $*
set guicursor=n-v-c:block-Cursor/lCursor,a:blinkwait1000-blinkoff500-blinkon500,i-ci:ver25-Cursor/lCursor,o:hor50-Cursor,r-cr:hor25-Cursor/lCursor,sm:block-Cursor,ve:ver25-Cursor
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set listchars=tab:»\ ,trail:·,extends:→,precedes:←
set makeprg=php\ -l\ %
set more
set mouse=a
set mousefocus
set mousemodel=extend
set noautochdir
set nocompatible
set nocul
set noequalalways
set noerrorbells
set noexpandtab
set noignorecase
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
set softtabstop=4
set spelllang=en_au,en
set tabstop=4
set tags=./tags;/
set textwidth=78
set ttyfast
set updatetime=1
set visualbell
set wildmenu
set winminheight=0
set winminwidth=0
set wrap
syntax on

