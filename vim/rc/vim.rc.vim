let $CACHE = expand('~/.cache')
let $VIMRC = expand('<sfile>:p')

let s:rc_dir = expand('~/dotfiles/vim/rc')

" define <Leader>
let mapleader = "\<Space>"

" Load rc files.
execute 'source' . s:rc_dir . '/maping.rc.vim'
execute 'source' . s:rc_dir . '/option.rc.vim'

" Load dein.
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_dir, ':p')
endif

" Get toml file path.
let s:dein_dir = $CACHE . '/dein'
let s:toml = s:rc_dir . '/dein.toml'
let s:lazy = s:rc_dir . '/dein-lazy.toml'
let s:ddc = s:rc_dir . '/ddc.toml'

" Load plugin by dein.
if dein#min#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml)
  call dein#load_toml(s:lazy, {'lazy': 1})
  call dein#load_toml(s:ddc, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
