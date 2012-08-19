call pathogen#infect()
syntax on
filetype plugin indent on

colorscheme slate
set background=dark
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized

set bg=dark
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

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

"autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 omnifunc=pysmell#Complete
"autocmd FileType python set complete+=k/opt/code/python/.pydiction iskeyword+=.,( 
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

let g:tagbar_usearrows = 1
set tags+=~/.tags
nnoremap <leader>l :TagbarToggle<CR>

"function! Smart_TabComplete()
"  let line = getline('.')                         " current line
"
"  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
"                                                  " line to one character right
"                                                  " of the cursor
"  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
"  if (strlen(substr)==0)                          " nothing to match on empty string
"    return "\<tab>"
"  endif
"  let has_period = match(substr, '\.') != -1      " position of period, if any
"  let has_slash = match(substr, '\/') != -1       " position of slash, if any
"  if (!has_period && !has_slash)
"    return "\<C-X>\<C-P>"                         " existing text matching
"  elseif ( has_slash )
"    return "\<C-X>\<C-F>"                         " file matching
"  else
"    return "\<C-X>\<C-O>"                         " plugin matching
"  endif
"endfunction

map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

nmap <C-s><C-x> :ScreenSend<CR>
nmap <C-s><C-q> :ScreenQuit<CR>
"nmap <C-s><C-p> :IPython<CR>
"inoremap <C-space> <C-x><C-o>

if(exists("$HOME/.vim/neosetup.vim"))
    source $HOME/.vim/neosetup.vim
endif
