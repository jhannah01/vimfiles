set nocp
filetype off

set rtp+=/data/local/home/.vim/bundle/vundle/
call vundle#rc("/data/local/home/.vim/bundle")

Bundle 'gmarik/vundle'
source /data/local/home/.vim/vimrc.vundle

filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins
syntax on

set hlsearch        " search highlighting
"colorscheme elflord
colorscheme kolor
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
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

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
" Enable omni completion. (Ctrl-X Ctrl-O)
"---------------------------------------------
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \ if &omnifunc == "" |
                \   setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
endif
set cot-=preview    "disable doc preview in omnicomplete

"---------------------------------------------
" for PHP programming
"---------------------------------------------
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

"---------------------------------------------
" for edit CSS
"---------------------------------------------
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss           set ft=scss.css
autocmd BufNewFile,BufRead *.sass           set ft=sass.css

"---------------------------------------------
" for edit HTML
"---------------------------------------------
autocmd FileType html,xhtml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

"---------------------------------------------
" file type detection
"---------------------------------------------
" highlight action script and mxml syntax
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript
au BufNewFile,BufRead *.less set filetype=less

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

" --- neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 0
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default': '',
            \ 'vimshell': '~/.vimshell_hist',
            \ 'scheme': '~/.gosh_completions'
            \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
"fun! s:my_cr_func()
"    return pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
"endfun
"inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
"inoremap <silent> <CR> <C-r>=<SID>my_cr_func()<CR>
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" --- vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" --- php-search-doc, vim-jquery-doc
let g:php_search_doc_command = 'open'
let g:php_search_doc_function_mapping='<Leader>pf'
let g:php_search_doc_manual_mapping='<Leader>pm'
let g:jquery_doc_command = 'open'
let g:jquery_doc_mapping = '<Leader>jm'

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

"--------------------
" For JavaScriptLint
" Ref: http://panweizeng.com/write-javascript-in-vim.html
"--------------------
"autocmd FileType javascript set makeprg=~/bin/jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ ~/bin/jsl.default.conf\ -process\ %
"autocmd FileType javascript set errorformat=%f(%l):\ %m
"autocmd FileType javascript inoremap <silent> <F9> <C-O>:make<CR>
"autocmd FileType javascript map <silent> <F9> :make<CR>

"--------------------
" for using php-cs-fixer
"--------------------
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"--------------------
" insert php namespace
"--------------------
imap <buffer> <leader><Leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <leader><Leader>u :call PhpInsertUse()<CR>

"--------------------
" For phpDocumentor (pdv)
"--------------------
inoremap <leader>pd <ESC>:call PhpDocSingle()<CR>i 
nnoremap <leader>pd :call PhpDocSingle()<CR> 
vnoremap <leader>pd :call PhpDocRange()<CR>  

let g:BASH_GlobalTemplateFile = $HOME.'/.vim/bash-support/templates/Templates'

if exists('g:pymode_options_max_line_length')
    let g:pymode_options            = 1 " Set default python options
    let g:pymode_warnings           = 1 " Disable noisy warnings
    let g:pymode_folding            = 1 " Enable folding by default
    let g:pymode_lint               = 0 " Disable pylint
    let g:pymode_rope_autoimport    = 1 " Enable autoimport rope completion
    let g:pymode_rope_autoimport_modules = ['os', 'os.path', 're', 'shutil', 'sys', 'datetime']
    let g:pymode_rope_autoimport_import_after_complete  = 1
    let g:pymode_options_max_line_length = 120
  
    " Override go-to.definition key shortcut to Ctrl-]
    let g:pymode_rope_goto_definition_bind = "<C-]>"

    " Override run current python file key shortcut to Ctrl-Shift-e
    let g:pymode_run_bind = "<C-S-e>"

    " Override view python doc key shortcut to Ctrl-Shift-d
    let g:pymode_doc_bind = "<C-S-d>"
endif


"let g:pymode_lint_config = $HOME.'/.pylint.rc'

source /data/local/home/.vim/vimrc-init.vim
