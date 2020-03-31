set laststatus=2
set statusline=                  | " Replace statusline
set statusline+=[%n]             | " Buffer number
set statusline+=\ %F             | " Full path to file
set statusline+=\ %m             | " Modified flag
set statusline+=\ %h             | " [help]
set statusline+=%r               | " Read only flag
set statusline+=%w               | " Preview window flag
set statusline+=%=%-5.(%l,%c%V%) | " Line, column-virtual column
set statusline+=\ %-5L           | " Lines in the buffer
