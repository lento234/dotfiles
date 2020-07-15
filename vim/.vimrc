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
Plugin 'tpope/vim-sensible'

Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/powerline'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'valloric/youcompleteme'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Plugin 'powerline/powerline'
" Plugin 'scrooloose/nerdtree'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/

" Colorschemes
colorscheme gruvbox
" colorscheme Tomorrow-Night
" colorscheme adaryn
" colorscheme midnight

let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
let g:gruvbox_contrast_dark='medium'

"
" ----------------- Standard customization ----------------------
"


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

" hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=237 
" hi StatusLine ctermfg=235 ctermbg=245
" hi StatusLineNC ctermfg=235 ctermbg=237
" hi Search ctermbg=58 ctermfg=15
" hi Default ctermfg=1
" hi clear SignColumn
" hi SignColumn ctermbg=235
" hi GitGutterAdd ctermbg=235 ctermfg=245
" hi GitGutterChange ctermbg=235 ctermfg=245
" hi GitGutterDelete ctermbg=235 ctermfg=245
" hi GitGutterChangeDelete ctermbg=235 ctermfg=245
" hi EndOfBuffer ctermfg=237 ctermbg=235
" 
set statusline=%=&P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set laststatus=2
set noshowmode

"
" ---------------- Keyboard mapping -----------------------
"

" Custom mapping
" Normal mode
nmap j ddp
nmap k dd<up>P
nmap <C-n> :NERDTreeToggle<CR>

" Insert mode
let mapleader = "\<Space>"

" Toggle line number: space + n
nnoremap <leader>n :set nu!<CR>

" hit space + space to remove highlights
nnoremap <leader><Space> :nohlsearch<CR>

" toggle paste mode
" this ignores indentation rules when pasting
nnoremap <leader>p :set paste! paste?<CR>

nnoremap <leader><Backspace> :bd<CR>

"
" -------------- Customization of plugins -------------------
"

"
" --- ctrlp ---
"

" configure ctrlp to use ag for searching
" this interacts nicely with the gitignore vim package
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

"
" --- YouCompleteMe ---
"

" don't seek confirmation every time ycm_conf file is found
let g:ycm_confirm_extra_conf = 0
let g:ymc_auto_trigger = 0

" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>t  ::YcmCompleter GetType<CR>
" print type of symbol under the cursor
nnoremap <leader>f  ::YcmCompleter FixIt<CR>
" refactor the name under the cursor
nnoremap <leader>r  ::YcmCompleter RefactorRename<space>
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" highlight YcmWarningSign    ctermfg=14
" highlight YcmWarningSection ctermfg=14
" highlight YcmErrorSign      ctermfg=14
" highlight YcmErrorSection   ctermfg=14
" 
" highlight YcmWarningSection cterm=bold
" highlight YcmErrorSection   cterm=bold
