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
set t_ut= " disable background color erase

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

autocmd FocusLost * silent! wa
set autowriteall

" tab navigation
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <F3>      :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <F4>      :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <F3>      <Esc>:tabprevious<CR>
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <F4>      <Esc>:tabnext<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" gui
set guioptions='ai' " quite minimal

" clipboard
" set clipboard=unnamedplus 

" general editing
inoremap <C-BS> <C-W>

inoremap <C-s> <ESC>:w<CR>i
nnoremap <C-s> :w<CR>

imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>


" training wheels: disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>



"  airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra' " repo, cwd, file pwd 

" gundo
nnoremap <F8> :GundoToggle<CR>
" easy motion
map <Leader>s <Plug>(easymotion-bd-w)

" neocomplete
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources = {}
let g:neocomplete#sources.go = ['omni']
inoremap <expr><C-n>  neocomplete#start_manual_complete()

" tweak omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" go lang settings
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go NeoCompleteEnable
au FileType go nmap <Leader>p :GoImport 
