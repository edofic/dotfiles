execute pathogen#infect()

set encoding=utf-8
set mouse=a
set mousehide " when typing
set ruler

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set backspace=indent,eol,start
set showmatch

syntax enable
" let g:rehash256 = 1 " molokai terminal optimization
colorscheme molokai
set t_ut= " disable background color erase

set number
set relativenumber

set incsearch
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set hlsearch
set ignorecase
set smartcase

set wildmenu
set wildmode=longest:full

set wrap
set linebreak

set directory=$HOME/.vim/swapfiles//
set tags=$HOME/.vimtags


filetype plugin indent on

" set digraph

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
set undofile
set undodir=$HOME/.vim/undo
set undolevels=10000
set undoreload=10000

" tab navigation
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>

" buffer navigation
noremap <C-B>  <Esc>:ToggleBufExplorer<CR>
" gz in command mode closes the current buffer
map gz :bdelete<cr>
" g[bB] in command mode switch to the next/prev. buffer
map gb :bnext<cr>
map gB :bprev<cr>
map <F5> gB
map <F6> gb

" gvim
if has("gui_running")
  set guioptions='ai' " quite minimal
  set guifont=Inconsolata\ 12
  set guiheadroom=-50
endif

" clipboard
" set clipboard=unnamedplus

set nofoldenable

set colorcolumn=80

" general editing
inoremap <C-BS> <C-W>
inoremap <C-s> <ESC>:w<CR>i
nnoremap <C-s> :w<CR>
nnoremap <Leader>f gqip
nnoremap <Leader>o vip:sort<CR>

" training wheels: disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nnoremap <Leader>b :BufOnly<CR>

" previous file
nnoremap ,, <C-^>


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


"  airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra' " repo, cwd, file pwd
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target|pkg|bin|build|node_modules)$',
  \ 'file': '\v\.(class|so|pyc)$',
  \ }

" gundo
nnoremap <F8> :GundoToggle<CR>

" easy motion
map <Leader>s <Plug>(easymotion-bd-w)

" word count
nnoremap <Leader>c :w !wc -w<CR>

" neocomplete
set completeopt=menuone " no annoying top window
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources = {}
" let g:neocomplete#sources.go = ['omni', 'omnifunc']
let g:neocomplete#sources.rust = ['omni', 'omnifunc']
inoremap <expr><C-n>  neocomplete#start_manual_complete()

" NERDtree
noremap <Leader>n <Esc>:NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" flake8
let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=1

" tweak omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
inoremap <C-n> <C-x><C-o>

" go lang settings
au FileType go nmap <buffer> <Leader>i <Plug>(go-info)
au FileType go NeoCompleteEnable
au FileType go nmap <buffer> <Leader>p :GoImport
au FileType go let b:dispatch = 'make goinstall'
au FileType go nnoremap <buffer> <Leader>:w :GoFmt<CR>:w<CR>

" git options
au FileType gitcommit setlocal textwidth=80 spell

" python options
function! RunPythonTests(folder, module)
  if match(a:module, '^test_') !=- 1
    let g:py_test_folder = a:folder
    let g:py_test_module = a:module
  endif
  :w
  :silent !echo;echo ;echo;echo;echo
  exec ":! cd " . g:py_test_folder . " ; python -m unittest " . g:py_test_module
endfunction

au FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 " override ftplugin/python
au FileType python nnoremap <C-F7> :call flake8#Flake8UnplaceMarkers()<CR>
au FileType python nnoremap <buffer> <Leader>u :call RunPythonTests(expand('%:p:h'), expand('%:t:r'))<CR>
au FileType python nnoremap <Leader>" /\([^"]\zs""\?\ze[^"]\)\<Bar>\([^"]\zs""\?\ze$\)<CR>

" javascript options
au FileType javascript nnoremap <buffer> <F7> :SyntasticCheck eslint<CR>

" haskell options
au FileType haskell nnoremap <buffer> <Leader>h "hyiw:exe "!stack hoogle ".@h<CR>
au FileType haskell nnoremap <buffer> <Leader>l mm:%!hindent<CR>`m

au FileType vimwiki setlocal textwidth=79

let g:LanguageClient_serverCommands = { 'rust': ['rls'] }
au FileType rust nnoremap <buffer> K :call LanguageClient_contextMenu()<CR>
au FileType rust nnoremap <buffer> <Leader>i :call LanguageClient#textDocument_hover()<CR>
