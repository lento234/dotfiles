"General configuration
" ...........................

syntax on
set autoindent
set number

set hlsearch
set background=dark
set mouse=a
set incsearch

" colorscheme base16-colors
colorscheme gruvbox 

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

" syntax on
" set ls=2
" set ruler

" Custom mapping
" Normal mode
nmap j ddp
nmap k dd<up>P

" let mapleader=','
" Insert mode
" imap <leader>' ''<ESC>i
