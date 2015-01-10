execute pathogen#infect()

set mouse=a
set ruler

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set autoindent
set backspace=indent,eol,start
set showmatch

syntax enable
colorscheme molokai
let g:rehash256 = 1 " molokai terminal optimization
set number

set incsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set hlsearch
set ignorecase
set smartcase

set wildmenu
set wildmode=longest:full

set directory=$HOME/.vim/swapfiles//

set encoding=utf-8

filetype plugin indent on


set ttimeout
set ttimeoutlen=100

set scrolloff=3
" set number

set autoread
set history=1000

"  airline
set laststatus=2

" ctrlp
let g:ctrlp_map = '<c-p>'

" easy motion
map <Leader> <Plug>(easymotion-prefix)
