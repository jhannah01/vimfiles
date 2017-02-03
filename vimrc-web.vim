autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"---------------------------------------------
" for PHP programming
"---------------------------------------------
""autocmd FileType php set makeprg=php\ -l\ %
""autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

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


"-----------------------
" for using php-cs-fixer
"-----------------------
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"---------------------
" insert php namespace
"---------------------
imap <buffer> <leader><Leader>u <C-O>:call PhpInsertUse()<CR>
map <buffer> <leader><Leader>u :call PhpInsertUse()<CR>

"------------------------
" For phpDocumentor (pdv)
"------------------------
inoremap <leader>pd <ESC>:call PhpDocSingle()<CR>i 
nnoremap <leader>pd :call PhpDocSingle()<CR> 
vnoremap <leader>pd :call PhpDocRange()<CR>  

" --- vim-javascript
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" --- php-search-doc, vim-jquery-doc
""let g:php_search_doc_command = 'open'
""let g:php_search_doc_function_mapping='<Leader>pf'
""let g:php_search_doc_manual_mapping='<Leader>pm'
""let g:jquery_doc_command = 'open'
""let g:jquery_doc_mapping = '<Leader>jm'

"--------------------
" For JavaScriptLint
" Ref: http://panweizeng.com/write-javascript-in-vim.html
"--------------------
"autocmd FileType javascript set makeprg=~/bin/jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ ~/bin/jsl.default.conf\ -process\ %
"autocmd FileType javascript set errorformat=%f(%l):\ %m
"autocmd FileType javascript inoremap <silent> <F9> <C-O>:make<CR>
"autocmd FileType javascript map <silent> <F9> :make<CR>

" vim: set ts=2 sw=2 ft=vim
