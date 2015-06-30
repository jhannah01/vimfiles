set nocompatible
filetype off

execute "set rtp+=".g:vimhome."/bundle/vundle"
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'gregsexton/MatchTag'
Bundle 'hdima/python-syntax'
Bundle 'scrooloose/syntastic'
Bundle 'Windows-PowerShell-Syntax-Plugin'
Bundle 'parkr/vim-jekyll'

filetype plugin indent on
