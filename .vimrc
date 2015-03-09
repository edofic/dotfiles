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
set hidden " undo after buffer switching

" persistent undo history
" set undofile
" set undodir=$HOME/.vim/undo
" set undolevels=1000
" set undoreload=10000

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

" buffer navigation
noremap <C-B>  <Esc>:ToggleBufExplorer<CR>
" gz in command mode closes the current buffer
map gz :bdelete<cr>
" g[bB] in command mode switch to the next/prev. buffer
map gb :bnext<cr>
map gB :bprev<cr>
map <F5> gB
map <F6> gb

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

" building
nnoremap <C-m> :make<CR><CR>


" training wheels: disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <Leader>b :BufOnly<CR>


"  airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra' " repo, cwd, file pwd 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target|bin|node_modules)$',
  \ 'file': '\v\.(class|so)$',
  \ }

" gundo
nnoremap <F8> :GundoToggle<CR>

" easy motion
map <Leader>s <Plug>(easymotion-bd-w)

" neocomplete
set completeopt=menuone " no annoying top window 
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources = {}
let g:neocomplete#sources.java = ['omnifunc']
let g:neocomplete#sources.go = ['omni', 'omnifunc']
inoremap <expr><C-n>  neocomplete#start_manual_complete()

" NERDtree
noremap <Leader>n <Esc>:NERDTreeToggle<CR>

" eclim
let g:EclimCompletionMethod='omnifunc'


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

" go java settings
au FileType java nmap <Leader>i :JavaDocPreview<CR>
au FileType java nmap <Leader>f :JavaSearch<CR>
au FileType java nmap <Leader>p :JavaImport<CR>
au FileType java NeoCompleteEnable
