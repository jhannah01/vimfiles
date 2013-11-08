filetype off

if(!exists("vimhome"))
    if (exists("$HOME/vim/vimrc"))
        let g:vimhome = $HOME.'/vim'
    elseif (exists("$HOME/home/vim/vimrc"))
        let g:vimhome = $HOME.'/home/vim'
    endif
endif

if (exists(g:vimhome.'/bundle/vundle'))
    set &rtp += vundlepath
    call vundle#rc(g:vimhome.'/bundle')

    Bundle 'gmarik/vundle'
    Bundle 'scrooloose/syntastic'
    Bundle 'xolox/vim-misc'
    Bundle 'tpope/vim-fugitive'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'Valloric/YouCompleteMe'
    Bundle 'wincent/Command-T'
    "Bundle 'xolox/vim-easytags'
    Bundle 'hdima/python-syntax'
    Bundle 'jmcantrell/vim-virtualenv'
    Bundle 'fisadev/fisa-vim-config'
    Bundle 'vim-scripts/python_ifold'
    "Bundle 'vim-scripts/pydoc.vim'
    Bundle 'tpope/vim-git'
    Bundle 'vim-scripts/vim-ipython'
    "Bundle 'jpalardy/vim-slime'
    Bundle 'mbbill/undotree'
    Bundle 'tpope/vim-surround'
    Bundle 'gotcha/vimpdb'
    Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'
    Bundle 'gregsexton/MatchTag'
    Bundle 'msanders/snipmate.vim'
endif

filetype plugin indent on
syntax on

execute 'set rtp+='.g:vimhome


colorscheme slate
"let g:solarized_termtrans=1
"let g:solarized_termcolors=64
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized

set nocp
set backspace=indent,eol,start
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

" Supertab settings
" supertab + eclim == java win

let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]

let g:SuperTabLongestHighlight = 1

"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 omnifunc=pysmell#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:tagbar_usearrows = 1

if (exists("$HOME/_tags"))
    set tags+=$HOME/_tags
endif

nnoremap <leader>l :TagbarToggle<CR>

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

nmap <C-s><C-x> :ScreenSend<CR>
nmap <C-s><C-q> :ScreenQuit<CR>
nmap <C-s><C-p> :IPython<CR>
"inoremap <C-space> <C-x><C-o>
