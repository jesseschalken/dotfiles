if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

filetype plugin indent on "no 'indent'
map <C-j> :bprev<CR>
map <C-k> :bnext<CR>
nnoremap , ;
nnoremap ; :
nnoremap <space> za
noremap $ g$
noremap 0 g0
noremap ^ g^
noremap j gj
noremap k gk
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set fileformats=unix,dos,mac
set grepprg=grep\ -nH\ $*
set guifont=Consolas:h12:b
set guioptions=
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set more
set mouse=a
set mousemodel=extend
set nocompatible
set noerrorbells
set nospell
set number
set ruler
set shell=bash
set shiftwidth=2
set showcmd
set showmatch
set showmode
set showtabline=2
set tabstop=2
set shiftwidth=2
set spelllang=en_au,en
set ttyfast
set wildmenu
set noswapfile
syntax on

if has('gui')
  let g:solarized_contrast="high"
  colorscheme solarized
  set background=light
endif
