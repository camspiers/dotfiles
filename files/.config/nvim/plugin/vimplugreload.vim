" PlugInstall and deletes plugins as needed
function! vimplugreload#run() abort
  let required = map(values(g:plugs), {_, plug -> plug.dir})
  if len(filter(copy(required), {_, dir -> !isdirectory(dir)}))
    PlugInstall
  endif
  let delete = filter(
    \ split(
      \ glob(g:plug_home.'/*/'),
      \ '\n'
    \ ),
    \ {_, dir -> index(required, dir) == -1}
  \ )
  if len(delete)
    call map(copy(delete), {_, dir -> delete(dir, 'rf')})
    echo 'Deleted plugins: ' . join(
      \ map(
        \ delete,
        \ {_, dir-> fnamemodify(dir[:-2], ':t')}
      \ ),
      \ ', '
    \ )
  endif
endfunction

augroup vimplugreload
  autocmd!
  " Auto sources vim files on save
  autocmd! BufWritePost *.vim source % | call vimplugreload#run()
augroup END
