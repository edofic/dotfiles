execute pathogen#infect()

set mouse=a
set mousehide " when typing
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

" tab navigation
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" gui
set guioptions='ai' " quite minimal

" clipboard
noremap <C-x> "+x
noremap <C-c> "+y
noremap <C-v> "+gP
inoremap <C-v> <Esc>"+gP<CR>i

" general editing
inoremap <C-BS> <C-W>


"  airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" ctrlp
let g:ctrlp_map = '<c-p>'

" easy motion
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-bd-w)

" neocomplete
let g:neocomplete#enable_at_startup = 1
