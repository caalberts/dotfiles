" Leader
let mapleader = "\<Space>"

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

set nocompatible
set number relativenumber 
set autochdir
set expandtab
set shiftwidth=2
set tabstop=2
set splitbelow
set splitright

set noswapfile
set autowrite

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

runtime! macros/matchit.vim

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-navigator'
Plug 'knubie/vim-kitty-navigator'
Plug 'jgdavey/tslime.vim'
Plug 'janko/vim-test'

" CodeCompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ruby plugins
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rails'

" Go plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" JS plugins
Plug 'moll/vim-node'

" Solidity plugins
" Plug 'TovarishFin/vim-solidity'

call plug#end()

" ColorSchema
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None

nnoremap <silent> <leader><C-t> :FZF<cr>

" remap pane navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

autocmd VimResized * :wincmd =
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>>

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-r> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = 'tslime'

" NERDTree
" Open NERDTree on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <leader>e :NERDTreeToggle<CR>

" FZF
nnoremap <silent> <C-t> :Files<CR>

" CodeCompletion
" Use <tab> for trigger completion and navigate to the next complete item
noremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set tags^=./.git/tags

let g:coc_global_extensions = ['coc-solargraph']

