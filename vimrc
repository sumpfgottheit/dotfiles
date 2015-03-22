version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim

set nocompatible

set runtimepath=/usr/share/dotfiles/p290/vim,$HOME/.vim,$VIMRUNTIME

"filetype off
"syntax off
call pathogen#infect()	" Pathogen plugin is used to load vim plugins that reside within .vim/bundle/
syntax on
filetype on
set background=dark


let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,latin1
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=de

set ruler
set viminfo='20,\"50

set tabstop=4
set shiftwidth=4

set history=5000		" 500 history entries
set undolevels=5000		" 500 undolevels
set cursorline			" Always show the line we are in
set showmode			" Always show the mode we are in
set autoindent			" Enable autoindenting
set smartindent			" Smart indening
set showmatch			" show matching bracketds
set ignorecase			" ignore case when searching
set smartcase			" Case sensitive searching when pattern contains upper case
set scrolloff=4			" keep 4 lines on the edge of the viewport
set hlsearch			" highlight search
set incsearch			" search as you type
set laststatus=2		" always show the status line
set nobackup			" dont't keep backupfiles
set noswapfile			" never used it...
set directory=~/.vim	" store swapfiles here, although they are disabled
set wildmenu			" tab completion like in bash
set wildmode=list:full	" show a list when pressing tab and select first full match
" vim: set ft=vim :

autocmd BufRead,BufNewFile *.mk set filetype=python     "check_mk-Files sind eigentlich Python Files
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType puppet setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType rst setlocal noautoindent nocindent nosmartindent indentexpr= tabstop=3 softtabstop=3 shiftwidth=3 expandtab

" syntastic - syntax checker
" Documentation in .vim/bundle/
let g:syntastic_auto_loc_list=1		" Auto open/close error window. ErrorWindow == loc_list
let g:syntastic_loc_list_height=5	" ErrorWindow is 5 lines height
" Autoclose Syntastic Window on Close
" Stackoverflow 4134027
cabbrev q lcl\|q
set t_Co=256
color saf
