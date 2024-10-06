function! vimrc#print_error(message) abort
  let lines = (type(a:message) ==# v:t_string ? a:message : a:message->string())->split("\n")
  echohl Error
  for line in lines
    echomsg '[vimrc] ' .. line
  endfor
  echohl None
endfunction

function! vimrc#typeof(value) abort
  let type_id = type(a:value)
  if type_id == v:t_string
    return 'string'
  elseif type_id == v:t_func
    return 'funcref'
  elseif type_id == v:t_list
    return 'list'
  elseif type_id == v:t_dict
    return 'dictionary'
  elseif type_id == v:t_float
    return 'float'
  elseif type_id == v:t_bool
    return 'boolean'
  elseif type_id == v:null
    return 'null'
  else
    return 'unknown'
  endif
endfunction

function! vimrc#set_b_undo_ftplugin(command) abort
  if a:command->type() !=# v:t_string
    call vimrc#print_error('Argument "com" must be a string, but got ' .. vimrc#typeof(a:command))
    return
  endif
  if exists('b:undo_ftplugin')
    if b:undo_ftplugin->stridx(a:command) >= 0
      return
    endif
    let b:undo_ftplugin = a:command .. ' | ' .. b:undo_ftplugin
  else
    let b:undo_ftplugin = a:command
  endif
endfunction
