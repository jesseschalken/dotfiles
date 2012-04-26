if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

"set guifont=Consolas:h12:b
"set listchars=tab:»\ ,eol:¬,extends:→,precedes:←,trail:·
"noremap <silent> <esc> :noh<CR>

autocmd BufEnter * silent! lcd %:p:h
filetype plugin indent on
noremap $ g$
noremap , ;
noremap 0 g0
noremap ; :
noremap <C-j> :bprev<CR>
noremap <C-k> :bnext<CR>
noremap <space> za
noremap ^ g^
noremap j gj
noremap k gk
set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set encoding=utf-8
set fileformats=unix,dos,mac
set grepprg=grep\ -nH\ $*
set guifont=Monospace\ Bold\ 10
set guioptions=agi
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:»\ ,eol:¬,extends:→,precedes:←
set more
set mouse=a
set mousefocus
set mousemodel=extend
set nocompatible
set nocul
set noequalalways
set noerrorbells
set nolist
set nospell
set noswapfile
set nowrap
set number
set ruler
set shell=bash
set shiftwidth=2
set showcmd
set showmatch
set showmode
set showtabline=2
set spelllang=en_au,en
set tabstop=2
set ttyfast
set wildmenu
set winminheight=0
set winminwidth=0
syntax on
