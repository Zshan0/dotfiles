" Set no compatiblity mode
set nocompatible


" Some needed settings
set number
set colorcolumn=80
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" vim-plug
call plug#begin('~/.vim/plugged')

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Auto Pairs plugin
Plug 'jiangmiao/auto-pairs'

" Ultisnips plugin
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Initialize vim-plug
call plug#end()

" Gruvbox theme
autocmd vimenter * colorscheme gruvbox

" Set Darkmode
set bg=dark

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Kite autocomplete by tab
let g:kite_tab_complete=1
