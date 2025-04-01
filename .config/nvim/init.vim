let g:new_config = 1

if exists('g:vscode')

else
  if g:new_config == 1
    lua require('user/init')
  else
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
  endif
endif


