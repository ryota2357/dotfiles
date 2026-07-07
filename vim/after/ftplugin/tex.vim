call vimrc#set_b_undo_ftplugin("setl ts< siso< fmr< inde<")
setlocal tabstop=2
setlocal sidescrolloff=10
setlocal foldmarker=!!!>,<!!!
setlocal indentexpr=

augroup vimrc_ft_tex
  autocmd!
  autocmd BufWritePre *.tex :call FixPunctuation()
augroup END
function! FixPunctuation() abort
  let l:pos = getpos('.')
  silent! execute ':%s/。/．/g'
  silent! execute ':%s/、/，/g'
  silent! execute ':%s/\\\@<!\s\+$//'
  call setpos('.', l:pos)
endfunction
