" Vundle Settings Head
" ref: https://github.com/VundleVim/Vundle.Vim#quick-start
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on
" Vundle Settings Tail

" Lightline Settings Head
set laststatus=2

if !has('gui_running')
    set t_Co=256
endif
" Lightline Settings Tail

nnoremap + <C-a>
nnoremap - <C-x>

set noswapfile
set ruler
set title
set wildmenu
set showcmd
set smartcase
set showmatch
set matchtime=1
"set expandtab
"set tabstop=4
"set shiftwidth=4
"set smarttab
"set autoindent
"set smartindent
"set whichwrap=b,s,h,l,<,>,[,]
set hlsearch
set incsearch
set number
set background=dark
set viminfo='20,\"10000
set display=lastline
colorscheme desert
highlight LineNr ctermfg=darkyellow
syntax on
