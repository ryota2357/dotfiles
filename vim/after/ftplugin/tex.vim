call vimrc#set_b_undo_ftplugin("setl ts< siso< fmr<")
setlocal tabstop=2
setlocal sidescrolloff=10
setlocal foldmarker=!!!>,<!!!

" autocmd BufWritePre *.tex :call FixPunctuation()
" function! FixPunctuation() abort
"   let l:pos = getpos('.')
"   silent! execute ':%s/。/. /g'
"   silent! execute ':%s/、/, /g'
"   silent! execute ':%s/\\\@<!\s\+$//'
"   call setpos('.', l:pos)
" endfunction
