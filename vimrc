set nocp
filetype off

set rtp+=/opt/vim/bundle/vundle/
call vundle#rc("/opt/vim/bundle")

Bundle 'gmarik/vundle'
source /opt/vim/vimrc.vundle

filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins
syntax on

set hlsearch        " search highlighting
"colorscheme elflord
colorscheme kolor
"colorscheme evening
set background=dark

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

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
set backspace=indent,eol,start

set showmatch       " Cursor shows matching ) and }
set showmode        " Show current mode
set wildchar=<TAB>  " start wild expansion in the command line using <TAB>
set wildmenu        " wild char completion menu

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 autoindent smarttab colorcolumn=120

" status line
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

" ignore these files while expanding wild chars
set wildignore+=.svn,CVS,.git 
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.lo,*.la,*.obj,*.pyc
set wildignore+=*.exe,*.zip,*.jpg,*.png,*.gif,*.jpeg

" folding
"set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 
" set leader to ;
let mapleader=";"
let g:mapleader=";"

" quick alias to leave vim
nmap <leader>w :x<CR> 
nmap <leader>q :q!<CR>

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" ;/ turn off search highlighting
nmap <leader>/ :set hls!<CR>
nnoremap <silent><leader>s :nohlsearch<CR>

" Bash like keys for the command line
"cnoremap <C-A>  <Home>
"cnoremap <C-E>  <End>
"cnoremap <C-K>  <C-U>

" ;p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" open the error console
map <leader>er :bo cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Quickly resize windows use +/-
"map - <C-W>-
"map + <C-W>+
"map > <C-W>>
"map < <C-W><

" Allows all window commands in insert mode
"imap <C-w> <C-o><C-w>

" Loop to switch windows
nmap <S-w> :wincmd w<CR>

" new tab
"map <C-t><C-t> :tabnew .<CR>
" close tab
"map <C-t><C-w> :tabclose<CR> 

"---------
"Functions
"---------
fun! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfun

fun! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfun

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
  let s:word = input("Replace " . expand('<cword>') . " with:") 
  :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
  :unlet! s:word 
endfun

"---------------------------------------------
" use w!! to write protected files
"---------------------------------------------
cmap w!! %!sudo tee > /dev/null % 

"---------------------------------------------
" copy to system buffer
"---------------------------------------------
vnoremap <C-S-C> "+y<CR>
map <C-S-c>  "+y<CR>
map <C-S-v> "+p<CR>

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
"map <C-[> <ESC>:po<CR>

map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
    let basename = substitute(bufname(""), '.*/', '', '')
    let guard = '_' . substitute(toupper(basename), '\.', '_', "H") . '_'
    call append(0, "#ifndef " . guard)
    call append(1, "#define " . guard)
    call append(line("$"), "#endif /* " . guard . " */")
endfun

"--------------------------------------------------------------------------- 
" COLOR SCHEME OVERRIDE
"--------------------------------------------------------------------------- 
hi StatusLine ctermfg=gray ctermbg=black
hi StatusLineNC ctermfg=darkblue ctermbg=gray

"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

" --- Syntastic
nnoremap <silent> <F6> :SyntasticCheck<CR>
nnoremap <leader>sy :SyntasticCheck<CR>
let g:syntastic_auto_loc_list = 1
"let g:syntastic_auto_jump = 1

" --- EasyMotion
let g:EasyMotion_leader_key = '<Leader><Leader>'    " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

" --- vim-easytags
nnoremap <leader>ut :UpdateTags!<CR>
nnoremap <leader>ht :HighlightTags<CR>
nnoremap <silent><leader>hh :let b:easytags_auto_highlight = 1<CR>
nnoremap <silent><leader>nh :let b:easytags_auto_highlight = 0<CR>
let g:easytags_dynamic_files = 1
let g:easytags_resolve_links = 1
" disable split by filetype, it seems is a bug!!
"let g:easytags_by_filetype = '~/.vim/tmp'

"---------------------------------------------
" using ctags
"---------------------------------------------
set tags=tags

"---------------------------------------------
" shorcut for ctags
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
"---------------------------------------------
map <C-\> :bel 8sp <CR>:exec("tag ".expand("<cword>"))<CR>

let g:BASH_GlobalTemplateFile = $HOME.'/.vim/bash-support/templates/Templates'

if exists('g:pymode_options_max_line_length')
    let g:pymode_options            = 1 " Set default python options
    let g:pymode_warnings           = 0 " Disable noisy warnings
    let g:pymode_folding            = 1 " Enable folding by default
    let g:pymode_lint               = 0 " Disable pylint
    let g:pymode_rope               = 0
    let g:pymode_rope_autoimport    = 0
    "let g:pymode_rope_autoimport_modules = ['os', 'os.path', 're', 'shutil', 'sys', 'datetime']
    let g:pymode_rope_autoimport_import_after_complete  = 0
    let g:pymode_options_max_line_length = 120
  
    " Override go-to.definition key shortcut to Ctrl-]
    let g:pymode_rope_goto_definition_bind = "<C-]>"

    " Override run current python file key shortcut to Ctrl-Shift-e
    let g:pymode_run_bind = "<C-S-e>"

    " Override view python doc key shortcut to Ctrl-Shift-d
    let g:pymode_doc_bind = "<C-S-d>"
endif


let g:pymode_options_max_line_length = 160

"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:jedi#popup_on_dot = 0
let g:ycm_key_list_select_completion = []

"let g:pymode_lint_config = $HOME.'/.pylint.rc'

source /opt/vim/vimrc-init.vim
