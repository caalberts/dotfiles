" Leader
let mapleader = "\<Space>"

nmap <leader>vr :sp $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

set nocompatible
set number
set autochdir
set noswapfile
set autowrite
set expandtab
set shiftwidth=2

runtime! macros/matchit.vim

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'kana/vim-textobj-user'

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

