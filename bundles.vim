set nocompatible
filetype off

execute "set rtp+=".g:vimhome."/bundle/vundle"
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'vim-scripts/vim-ipython'
"Bundle 'johndgiese/vipy'
Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
Bundle 'gregsexton/MatchTag'
Bundle 'hdima/python-syntax'
Bundle 'scrooloose/syntastic'
Bundle 'Windows-PowerShell-Syntax-Plugin'
Bundle 'jmcantrell/vim-virtualenv'

filetype plugin indent on
