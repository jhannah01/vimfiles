filetype off

if (exists("$HOME/.vim/bundle/vundle"))
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle'
    Bundle 'scrooloose/syntastic'
    Bundle 'xolox/vim-misc'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'wincent/Command-T'
    Bundle 'hdima/python-syntax'
    "Bundle 'jmcantrell/vim-virtualenv'
    Bundle 'fisadev/fisa-vim-config'
    Bundle 'vim-scripts/python_ifold'
    "Bundle 'vim-scripts/pydoc.vim'
    Bundle 'tpope/vim-git'
    Bundle 'vim-scripts/vim-ipython'
    "Bundle 'jpalardy/vim-slime'
    Bundle 'mbbill/undotree'
    Bundle 'tpope/vim-surround'
    Bundle 'gotcha/vimpdb'
    "Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
    Bundle 'gregsexton/MatchTag'
    "Bundle 'msanders/snipmate.vim'
    Bundle 'othree/html5.vim'
endif

filetype plugin indent on
syntax on

colorscheme elflord
set background=dark

set nocp
set ts=4
set sw=4
set expandtab
set smarttab
set smartindent 
set smartcase
set hlsearch
set magic
set hidden
set undolevels=1000
set wildignore=*.swp,*.pyc,*.pyo
set title
set noerrorbells
set mouse=a
set showcmd
set foldmethod=indent
set foldlevel=99
set backspace=indent,eol,start

"let g:pydiction_location = "$HOME/.vim/pydiction/complete-dict"
"let g:pydiction_menu_height = 20

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

if (exists("/opt/code/.tags"))
    set tags+=/opt/code/.tags
endif

if (exists("~/.tags"))
    set tags+=~/.tags
endif

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

"nmap <C-s><C-x> :ScreenSend<CR>
"nmap <C-s><C-q> :ScreenQuit<CR>
nmap <C-s><C-p> :IPython<CR>

nmap <C-t>n :tabnew<CR>
nmap <C-t>C :tabclose<CR>
nmap <C-t><C-t> :tablast<CR>
nmap <C-Tab><C-Tab> :tabNext<CR>
nmap <C-Tab>p :tabprevious<CR>
