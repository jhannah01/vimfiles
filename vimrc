"let s:base_path = resolve(expand(fnamemodify('<sfile>', ':p:h')))
let s:base_path = '/usr/local/vimfiles'
let s:vundle_path = '/usr/local/vimfiles/bundle/vundle'
filetype off

if (!empty(glob(s:vundle_path)))
    exe 'set rtp+='.s:vundle_path
    call vundle#rc()

    if (empty(glob(s:base_path . "/vimrc.vundle")))
        echo "Missing vimrc.vundle file in ".s:base_path
    endif

    exe 'source '.s:base_path.'/vimrc.vundle'
endif

filetype plugin indent on
syntax on

"colorscheme elflord
colorscheme kolor
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
set mouse=
set showcmd
set foldmethod=indent
set foldlevel=99

"let g:pydiction_location = "$HOME/.vim/pydiction/complete-dict"
"let g:pydiction_menu_height = 20

if (exists("~/.pylint.rc"))
    let g:pymode_lint_config = '$HOME/.pylint.rc'
endif
let g:pymode_lint_options_pep8={'max_line_length': 200}

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

if (exists("~/.tags"))
    set tags+=~/.tags
elif (exists(s:base_path."/.tags"))
    set tags+=s:base_path."/.tags"
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
