if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	set guifont=Consolas:h12:b
	set guioptions=agi
elseif has('mac')
	set guifont=Menlo\ Bold:h18
	set guioptions=agie
else
	set guifont=Monospace\ Bold\ 10
	set guioptions=agi
endif

if has('gui_running')
	colorscheme solarized
	set background=light
else
	colorscheme default
	set background=dark
endif

autocmd BufEnter * silent! lcd %:p:h
autocmd CursorHold * silent! update

filetype plugin indent on
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
set foldlevelstart=0
set foldmethod=syntax
set formatoptions=tcqro
set grepprg=grep\ -nH\ $*
set guicursor=n-v-c:block-Cursor/lCursor,a:blinkwait1000-blinkoff500-blinkon500,i-ci:ver25-Cursor/lCursor,o:hor50-Cursor,r-cr:hor25-Cursor/lCursor,sm:block-Cursor,ve:ver25-Cursor
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set list
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
set nonumber
set nosmartcase
set nospell
set noswapfile
set nowrap
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
set ttyfast
set updatetime=1
set wildmenu
set winminheight=0
set winminwidth=0
syntax on
