"General configuration
" ...........................

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'powerline/powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Plugin 'powerline/powerline'
" Plugin 'scrooloose/nerdtree'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/

syntax on
set autoindent
set number

set hlsearch
set background=dark
set mouse=a
set incsearch

" expand tab to space
" real tab is now Ctrl-V<Tab>
set tabstop=4
set shiftwidth=4
set expandtab

let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Colorschemes
" colorscheme gruvbox
" colorscheme Tomorrow-Night
colorscheme adaryn
" colorscheme midnight

hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=237 
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=237 ctermbg=235

set statusline=%=&P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode

syntax on
" set ls=2
" set ruler

set tabstop=4
set shiftwidth=4
set expandtab

" Custom mapping
" Normal mode
nmap j ddp
nmap k dd<up>P
nmap <C-n> :NERDTreeToggle<CR>

" Insert mode
" imap <leader>' ''<ESC>i
let mapleader = "\<Space>"

" Toggle line number: space + n
nnoremap <leader>n :set nu!<CR>
" hit space + space to remove highlights
nnoremap <leader><Space> :nohlsearch<CR>
