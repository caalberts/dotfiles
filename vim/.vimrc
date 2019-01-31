" Leader
let mapleader = "\<Space>"

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

set nocompatible
set number
set autochdir
set expandtab
set shiftwidth=2
set splitbelow
set splitright

set noswapfile
set autowrite

runtime! macros/matchit.vim

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'kana/vim-textobj-user'
Plug 'christoomey/vim-tmux-navigator'

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

call plug#end()

nnoremap <silent> <leader><C-t> :FZF<cr>

" remap pane navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

autocmd VimResized * :wincmd =
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>>
