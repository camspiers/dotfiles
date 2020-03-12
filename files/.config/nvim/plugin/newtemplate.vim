" Create a buffer of the specified type
function! newtemplate#new(filetype, vertical) abort
  let filetypes = getcompletion('', 'filetype')
  if index(filetypes, a:filetype) == -1
    echo a:filetype . " is not a valid filetype"
    return
  endif
  if a:vertical | vnew | else | new | endif
  execute 'setf ' . a:filetype
  call NaturalVerticalDrawer()
endfunction


" For empty files it attempts to read a template. Not using au BufNewFile as the
" filetype is being manually set by :New instead of via *.php
function! newtemplate#load() abort
  if line('$') == 1 && col('$') == 1
    silent! execute ":0r ~/.config/nvim/templates/" . &filetype
    :$
  endif
endfunction

augroup newtemplate
  autocmd!
  " Reads templates into empty files
  autocmd! FileType * call newtemplate#load()
  " }}}
augroup END

" Create new buffers of a particular filetype
command! -nargs=1 -complete=filetype New :call newtemplate#new(<f-args>, v:false)
command! -nargs=1 -complete=filetype Vnew :call newtemplate#new(<f-args>, v:true)
