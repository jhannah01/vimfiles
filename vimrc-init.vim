filetype on
filetype indent on
filetype plugin on
syntax on

set hlsearch
set background=dark

colorscheme elflord
"colorscheme kolor


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

set nocompatible
if has('python') " if dynamic py|py3, this line already activates python2.
  let s:python_version = 2
elseif has('python3')
  let s:python_version = 3
else
  let s:python_version = 0
endif

" echomsg 'Using python'.s:python_version


set nocp
set ts=4
set sw=4
set tags=tags
set expandtab
set smarttab
set smartindent 
set smartcase
set hlsearch
set magic
set hidden
set undolevels=1000
set wildignore=*.swp,*.pyc,*.pyo,.DS_Store
set title
set noerrorbells
set mouse=
"set mouse=a
set showcmd
set backspace=indent,eol,start

set showmatch       " Cursor shows matching ) and }
set showmode        " Show current mode
set wildchar=<TAB>  " start wild expansion in the command line using <TAB>
set wildmenu        " wild char completion menu

autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 autoindent smarttab

" status line
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

" ignore these files while expanding wild chars
set wildignore+=.svn,CVS,.git
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.lo,*.la,*.obj,*.pyc
set wildignore+=*.exe,*.zip,*.jpg,*.png,*.gif,*.jpeg,.DS_Store

" folding
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

" ---------
" Functions
" ---------

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
cnoremap <C-A>  <Home>
cnoremap <C-E>  <End>
cnoremap <C-K>  <C-U>

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
map - <C-W>-
map + <C-W>+
map > <C-W>>
map < <C-W><

" Allows all window commands in insert mode
imap <C-w> <C-o><C-w>

" Loop to switch windows
nmap <S-w> :wincmd w<CR>

" new tab
map <C-t><C-t> :tabnew .<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
  let s:word = input("Replace " . expand('<cword>') . " with:") 
  :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
  :unlet! s:word 
endfun

"---------------------------------------------
" use syntax complete if nothing else available
"if has("autocmd") && exists("+omnifunc")
"    autocmd Filetype * if &omnifunc == "" |   setlocal omnifunc=syntaxcomplete#Complete | endif
"endif

"#"set cot-=preview    "disable doc preview in omnicomplete

" --------------------------------
" use w!! to write protected files
" --------------------------------
cmap w!! %!sudo tee > /dev/null % 

" ---------------------
" copy to system buffer
" ---------------------
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

" --- neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 0

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
" shorcut for ctags
" http://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks
"---------------------------------------------
map <C-\> :bel 8sp <CR>:exec("tag ".expand("<cword>"))<CR>

" ----------
" For pymode
" ----------

let g:pymode_options            = 1 " Set default python options
let g:pymode_warnings           = 1 " Disable noisy warnings
let g:pymode_folding            = 0 " Don't enable folding by default
let g:pymode_lint               = 0 " Disable pylint
let g:pymode_rope               = 0
let g:pymode_rope_autoimport    = 1 " Enable autoimport rope completion
let g:pymode_rope_autoimport_modules = ['os', 're', 'shutil', 'sys', 'datetime']
let g:pymode_rope_autoimport_import_after_complete  = 1

" -------------
" For Syntastic
" -------------

" disable syntastic on a per buffer basis (some work files blow it up)
function! SyntasticDisableBuffer()
    let b:syntastic_skip_checks = 1
    SyntasticReset
    echo 'Syntastic disabled for this buffer'
endfunction

command! SyntasticDisableBuffer call SyntasticDisableBuffer()

"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }
noremap <C-w>e :SyntasticCheck<CR> 
noremap <C-w>f :SyntasticToggleMode<CR>
" Ctrl-w + e shall enable checking
" Ctrl-w + f shall disable checking 

" To disable warnings use: 
"let g:syntastic_quiet_messages={'level':'warnings'}

let b:syntastic_mode='passive'
nnoremap <leader>sN :bufdo let b:syntastic_mode='passive'<CR>
nnoremap <leader>sY :bufdo unlet b:syntastic_mode<CR>

" -------------------------------------------
" Fix bash-support directory
" $HOME/.vim/bash-support/templates/Templates
" directory missing
" -------------------------------------------

let g:BASH_GlobalTemplateFile = $HOME.'/.vim/bash-support/templates/Templates'

function! CheckBashTemplateDir()
    let bash_template_dir = fnamemodify(g:BASH_GlobalTemplateFile, ":p:h")

    if !isdirectory(bash_template_dir)
        call mkdir(bash_template_dir, "p")
    endif

    if !filereadable(g:BASH_GlobalTemplateFile)
        call system("touch " . g:BASH_GlobalTemplateFile)
    endif
endfunction

call CheckBashTemplateDir()

" vim: set ts=2 sw=2 ft=vim
