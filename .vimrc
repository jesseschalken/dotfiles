if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	set guifont=Consolas:h12:b
else
	set guifont=Monospace\ Bold\ 10
endif

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
set guicursor=n-v-c:block-Cursor/lCursor,a:blinkwait500-blinkoff500-blinkon500,i-ci:ver25-Cursor/lCursor,o:hor50-Cursor,r-cr:hor25-Cursor/lCursor,sm:block-Cursor,ve:ver25-Cursor
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
