filetype plugin on
let NERDSpaceDelims=1
set autochdir
set autoindent
set autowrite
set background=dark
set errorformat=%m\ in\ %f\ on\ line\ %l
set foldexpr=min([8,(getline(v:lnum)=~'^\\s*$'?max([indent(v:lnum-1),indent(v:lnum+1)]):indent(v:lnum))/&sw])
set foldmethod=expr
set formatoptions=tcqro
set guifont=Monospace\ 8
set guioptions-=L
set guioptions-=R
set guioptions-=T
set guioptions-=b
set guioptions-=l
set guioptions-=m
set guioptions-=r
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set makeprg=php\ -l\ %
set mouse=a
set mousefocus
set nocul
set noequalalways
set noexpandtab
set nonumber
set noswapfile
set nowrap
set nowrapscan
set ruler
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set tabstop=2
set wildmenu
set winminheight=0
set winminwidth=0
syntax on
