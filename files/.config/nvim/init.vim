" Environment requirements:
" - tmux
" - nvim
" - python3 support
" - fzf
" - vim plug
" - Font with devicons
" - yarn
" - ripgrep

call plug#begin(stdpath('data') . '/plugged')
    " Fuzzy file finding
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " Syntax
    Plug 'StanAngeloff/php.vim'

    " Status line
    Plug 'vim-airline/vim-airline'

    " Themes for airline
    Plug 'vim-airline/vim-airline-themes'

    " Import tabs etc from editorconfig
    Plug 'editorconfig/editorconfig-vim'

    " Common COC plugins
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
    Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
    " Need to manually run :CocInstall coc-phpls
    " Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}

    " Startup screen
    Plug 'mhinz/vim-startify'

    " Helps root switching
    Plug 'airblade/vim-rooter'

    " Syntax support
    Plug 'leafgarland/typescript-vim'

    " Typescript jsx support
    Plug 'peitalin/vim-jsx-typescript'

    " SilverStripe template support
    Plug 'phalkunz/vim-ss'

    " Vim prettier suport
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " Better commenting
    Plug 'tomtom/tcomment_vim'

    " Show indentation
    Plug 'Yggdroot/indentLine'

    " No distraction omde
    Plug 'junegunn/goyo.vim'

    " Blade templating support
    Plug 'jwalton512/vim-blade'

    " Markdown preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

    " Makes tmux use airline colors
    Plug 'edkolev/tmuxline.vim'

    " Standard terminal integration improvements
    Plug 'wincent/terminus'

    " Cyclic navigation bindings for filetypes and file patterns
    Plug 'tpope/vim-projectionist'

    " Integrates with projectionist to add 'Ftype' stype commanges
    Plug 'c-brenn/fuzzy-projectionist.vim'

    " Toggle relative line numbering <Leader>r
    Plug 'jeffkreeftmeijer/vim-numbertoggle'

    " Find and replace via quickfix list
    Plug 'stefandtw/quickfix-reflector.vim'

    " Allows Rg to populate the quickfix list
    Plug 'jremmen/vim-ripgrep'

    " Surround motions
    Plug 'tpope/vim-surround'

    " PHP Debugging
    Plug 'vim-vdebug/vdebug'

    " Show git info in sidebar
    Plug 'mhinz/vim-signify'

    " Adds ability to adjust alignment in visual mode
    Plug 'godlygeek/tabular'

    " Motions for inside camel case
    Plug 'bkad/CamelCaseMotion'

    " Dev icons
    Plug 'ryanoasis/vim-devicons'

    " Docker compose tools
    Plug 'skanehira/docker-compose.vim'
    Plug 'ekalinin/dockerfile.vim'

    " Adds composer command support
    Plug 'noahfrederick/vim-composer'

    " Nice theme, use this theme with terminal too
    Plug 'arcticicestudio/nord-vim'

    " Improves netrw
    Plug 'tpope/vim-vinegar'

    " Allows for opening multiple files
    Plug 'PhilRunninger/nerdtree-visual-selection'

    " Adds a bunch of themes
    Plug 'rafi/awesome-vim-colorschemes'

    " Allows cycling through themes
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-colorscheme-switcher'

    " Allows repeating of various custom commands
    Plug 'tpope/vim-repeat'

    " Allows for easy repeat of last used macro
    Plug 'wincent/replay'

    " Jump to interesting places with a Git or Mercurial repo
    Plug 'wincent/vcs-jump'

    " Split and join programming lines
    Plug 'AndrewRadev/splitjoin.vim'

    " File browser
    Plug 'vifm/vifm.vim'

    Plug 'lilyball/vim-swift'
call plug#end()

set shell=bash

" Default options
set encoding=UTF-8 " Default file encoding
set undofile " Enable undo persistence across sessions
set history=10000 " The lines of history to remember
set autoread " Automatically read the file when it's changed outside VIM
set number " Show line numbers
set ruler " Always show current position
set lazyredraw " Don't redraw while performing a macro
set showmatch " Show matching braces
set cursorline " Enable current line indicator
set splitbelow splitright
set ttimeoutlen=50
set noautochdir
set clipboard=unnamed

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" Indent
set tabstop=4
set shiftwidth=4
set expandtab

" No sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Syntax
if !exists('g:syntax_on')
	syntax enable
endif
filetype plugin indent on

" Visual configuration
colorscheme nord
set termguicolors

" Better indents
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

set wildignore+=.git,.DS_Store

" Configures ripgrep with fzf
command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rgg call fzf#vim#grep("rg --no-ignore --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Allow Ripgrep to work with quick list
command! -nargs=* -complete=file Ripgrep :call s:Rg(<q-args>)
command! -nargs=* -complete=file Rg :call s:Rg(<q-args>)

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'

" Configure FZF to use a floating window configuration
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine'],
            \ 'bg+':     ['bg', 'Normal'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'CursorLine'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Using floating windows of Neovim to start fzf
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Configure Airline Theme
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Fix netrw buffer issue
let g:netrw_fastbrowse = 0

" Cycle through relativenumber + number, number (only), and no numbering.
function! CycleNumbering() abort
  if exists('+relativenumber')
    execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
  else
    " No relative numbering, just toggle numbers on and off.
    set number!<CR>
  endif
endfunction

" Better buffer navigation
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Open startify with leader l
nnoremap <silent> <Leader>l :Startify<CR>

" Open fuzzy files with leader \
nnoremap <silent> <Leader>\ :Files<CR>

" Open fuzzy lines with leader o
nnoremap <silent> <Leader>o :Lines<CR>

" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>

" Open grep
nnoremap <silent> <Leader>g :FzfRg<CR>

" Open grep for cursor word
nnoremap <silent> <Leader>w :FzfRg <C-R><C-W><CR>

" Close the current buffer
nnoremap <silent> <Leader>x :bd<CR>

" Close all buffers
nnoremap <silent> <Leader>z :%bd<CR>

" Remove search highlighting with leader n
nnoremap <leader>n :noh<CR>

" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>

" Alternate file navigation vertical split
nnoremap <silent> <Leader>v :AV<CR>

" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleNumbering()<CR>

" Better split creation, configured to match with tmux
nnoremap <silent> <Leader>\| :vsp<CR>
nnoremap <silent> <Leader>- :sp<CR>

" More intuitive split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" COC configuration

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Remove messages from in-completion menus
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" gh - get hint on whatever's under the cursor
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" end COC

" Don't start markdown preview automatically, use :MarkdownPreview
let g:mkdp_auto_start = 0

" Configures tmux line, use :TmuxlineSnapshot ~/.tmux/airline.conf to save
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#(whoami)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'z'    : ['%R', '%a', '%Y']}

let g:indentLine_setConceal = 0

" Use docker files and git
let g:rooter_patterns = ['docker-compose.yml', '.git']

" Vedebug needs to be able to load files and understand how the file in the docker container maps to the local system
autocmd VimEnter * :call Vdebug_load_options( { 'path_maps' : { '/var/www/html/' : getcwd() } } )

" Special focus improvements inspired by wincent
" Better focus highlighting for blurred windows
let g:ColorColumnBlacklist = ['diff', 'undotree', 'nerdtree', 'qf', 'startify']

function! ShouldColorColumn() abort
  return index(g:ColorColumnBlacklist, &filetype) == -1
endfunction

function! BlurWindow() abort
  if ShouldColorColumn()
    if !exists('w:wincent_matches')
      " Instead of unconditionally resetting, append to existing array.
      " This allows us to gracefully handle duplicate autocmds.
      let w:wincent_matches=[]
    endif
    let l:height=&lines
    let l:slop=l:height / 2
    let l:start=max([1, line('w0') - l:slop])
    let l:end=min([line('$'), line('w$') + l:slop])
    while l:start <= l:end
      let l:next=l:start + 8
      let l:id=matchaddpos(
            \   'Comment',
            \   range(l:start, min([l:end, l:next])),
            \   1000
            \ )
      call add(w:wincent_matches, l:id)
      let l:start=l:next
    endwhile
  endif
endfunction

function! FocusWindow() abort
  if ShouldColorColumn()
    if exists('w:wincent_matches')
      for l:match in w:wincent_matches
        try
          call matchdelete(l:match)
        catch /.*/
          " In testing, not getting any error here, but being ultra-cautious.
        endtry
      endfor
      let w:wincent_matches=[]
    endif
  endif
endfunction

if exists('+colorcolumn')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * if ShouldColorColumn() | let &colorcolumn=join(range(120,999),",") | endif
  autocmd FocusLost,WinLeave * if ShouldColorColumn() | let &l:colorcolumn=0 | endif
endif

if exists('*matchaddpos')
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * call FocusWindow()
  autocmd FocusLost,WinLeave * call BlurWindow()
endif

" Sets up within word motions to use ,
let g:camelcasemotion_key = ','

