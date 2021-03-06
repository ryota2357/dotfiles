let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

" define <Leader>
let mapleader = "\<Space>"

if has('nvim')
  " Use filetype.lua instead.
  let g:do_filetype_lua = 1
  let g:did_load_filetypes = 0
endif

" Load dein.
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_dir, ':p')
endif

" dein configurations.
let g:dein#enable_notification = v:true
let g:dein#install_progress_type = 'floating'
let g:dein#auto_recache = v:true
let g:dein#install_max_processes = 1 " 時間かかるけど、エラーは出なくなる

" plugin's downloaded path.
let s:path = $CACHE . '/dein'

" Load plugin by dein.
if dein#min#load_state(s:path)
  let s:rc_dir = expand('~/dotfiles/vim/rc') . '/'

  let g:dein#inline_vimrcs = [
        \ s:rc_dir . 'option.rc.vim',
        \ s:rc_dir . 'maping.rc.vim'
        \]

  call dein#begin(s:path)

  call dein#load_toml(s:rc_dir . 'dein.toml')
  call dein#load_toml(s:rc_dir . 'dein-lazy.toml', {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'ddc.toml', {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'ddu.toml', {'lazy': 1})
  call dein#load_toml(s:rc_dir . 'filetype.toml')

  call dein#end()
  call dein#save_state()
endif

set secure
