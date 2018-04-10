""""" Vundle Settings
""""" ref: https://github.com/VundleVim/Vundle.Vim#quick-start
""""" Launch vim and run ':PluginInstall'
""""" Command line running 'vim +PluginInstall +qall'
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'

call vundle#end()
filetype plugin indent on



""""" Lightline Settings
set laststatus=2
if !has('gui_running')
    set t_Co=256
endif



""""" tmuxline.vim Settings
""""" Launch tmux + vim and run ':Tmuxline' + ':TmuxlineSnapshot <ConfFileName>'
let g:tmuxline_preset = {
  \'a'    : '#S',
  \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
  \'win'  : ['#I', '#W'],
  \'cwin' : ['#I', '#W', '#F'],
  \'x'    : '#(date)',
  \'y'    : ['%R', '%a', '%Y'],
  \'z'    : '#H'}
let g:tmuxline_theme = 'lightline'



""""" Key Bindings
nnoremap + <C-a>
nnoremap - <C-x>


""""" Operation Settings
set noswapfile
set ruler
set title
set wildmenu
set showcmd
set smartcase
set showmatch
set matchtime=1
set noexpandtab
"set tabstop=4
"set shiftwidth=4
set nosmarttab
set noautoindent
set nosmartindent
set nocindent
"set whichwrap=b,s,h,l,<,>,[,]
set hlsearch
set incsearch
set number
set background=dark
set viminfo='20,\"10000
set display=lastline
set mouse=a
set ttymouse=xterm2
colorscheme desert
highlight LineNr ctermfg=darkyellow
syntax on
