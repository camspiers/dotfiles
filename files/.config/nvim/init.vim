" Environment requirements:
" - tmux
" - nvim
" - python3 support
" - fzf
" - vim plug
" - Font with devicons
" - yarn
" - ripgrep

"##############################################################################
" Plugins
"##############################################################################

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
    Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'branch': 'release/1.x',
    \ 'for': [
     \ 'javascript',
     \ 'typescript',
     \ 'css',
     \ 'less',
     \ 'json',
     \ 'graphql',
     \ 'markdown',
     \ 'vue',
     \ 'php',
     \ 'html' ] }

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

    " Syntax support for swift
    Plug 'lilyball/vim-swift'

    " Nicer scrolling
    Plug 'psliwka/vim-smoothie'

    " Common pane navigation for vim and tmux together
    Plug 'christoomey/vim-tmux-navigator'

    " Syntax highlighting for tmux conf
    Plug 'tmux-plugins/vim-tmux'

	" Nice docblock generator
	Plug 'kkoomen/vim-doge'

    " Personal wiki
    Plug 'vimwiki/vimwiki'
call plug#end()

"##############################################################################
" General Settings
"##############################################################################

" Default file encoding
set encoding=UTF-8

" Enable undo persistence across sessions
set undofile

" The lines of history to remember
set history=10000

" Automatically read the file when it's changed outside VIM
set autoread

" Split defaults
set splitbelow splitright

" Don't change dirs automatically, using rooter for that
set noautochdir

" System clipboard
set clipboard=unnamed

" Ignore patterns
set wildignore+=.git,.DS_Store

" No sound
set noerrorbells
set timeoutlen=500

"##############################################################################
" Searching
"##############################################################################

set ignorecase
set smartcase
set incsearch

augroup IncSearchHighlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

"##############################################################################
" Editing
"##############################################################################

set tabstop=4
set shiftwidth=4
set expandtab

"##############################################################################
" Visual Settings
"####################################################################################################################

" Add bulk color past 120
let &colorcolumn=join(range(121,999),",")

" Spell checking
set spelllang=en

" Turn spelling on for markdown files
autocmd FileType markdown setlocal spell

" Turn Goyo on for markdown
autocmd BufRead,BufNewFile *.md :Goyo 80

" Don't redraw while performing a macro
set lazyredraw

" Don't display visual bell
set novisualbell

" Show matching braces
set showmatch

" Enable current line indicator
set cursorline

" Show line numbers
set number

" Always show current position
set ruler

if !exists('g:syntax_on')
	syntax enable
endif

filetype plugin indent on
colorscheme nord
set termguicolors

"##############################################################################
" Mappings
"##############################################################################

" Next buffer
nnoremap <silent>   <tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <s-tab> :bprevious<CR>
" Create vsplit
nnoremap <silent> <Leader>\| :vsp<CR>
" Creat hsplit
nnoremap <silent> <Leader>- :sp<CR>
" Save file
nnoremap <silent> <Leader>w :w<CR>
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
nnoremap <silent> <Leader>c :FzfRg <C-R><C-W><CR>
" Close the current buffer
nnoremap <silent> <Leader>x :bd<CR>
" Close all buffers
nnoremap <silent> <Leader>z :%bd<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader>v :AV<CR>
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleNumbering()<CR>
" Open project
nnoremap <silent> <Leader>m :call ToggleProject()<CR>
" Open scratch term
nnoremap <silent> <Leader>s :call ToggleScratchTerm()<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call ToggleLazyGit()<CR>
" Open harvest
nnoremap <silent> <Leader>h :call ToggleHarvest()<CR>
" Open vifm
nnoremap <silent> <Leader>/ :Vifm<CR>
" Get outline
nnoremap <silent> <Leader>co :<C-u>CocList outline<CR>
" Get symbols
nnoremap <silent> <Leader>cs :<C-u>CocList -I symbols<CR>
" Get errors
nnoremap <silent> <Leader>cl :<C-u>CocList locationlist<CR>
" Get available commands
nnoremap <silent> <Leader>cc :<C-u>CocList commands<CR>
" Restart server
nnoremap <silent> <Leader>cR :<C-u>CocRestart<CR>
" Quit term buffer with ESC
tnoremap <silent> <Esc> <C-\><C-n><CR>
" Go to definition
nmap gd <Plug>(coc-definition)
" Go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Find references
nmap <silent> gr <Plug>(coc-references)
" Get hint
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>

"##############################################################################
" Commands
"##############################################################################

" Configures ripgrep with fzf
command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rgg call fzf#vim#grep("rg --no-ignore --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Allow Ripgrep to work with quick list
command! -nargs=* -complete=file Ripgrep :call s:Rg(<q-args>)
command! -nargs=* -complete=file Rg :call s:Rg(<q-args>)


"##############################################################################
" Plugin Configurations
"##############################################################################

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files
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

"##############################################################################
" Plugin Configurations
"##############################################################################

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"let g:vifm_replace_netrw = 1

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
let g:rooter_patterns = ['docker-compose.yml', '.git/']

" Change silently
let g:rooter_silent_chdir = 1

" Vdebug needs to be able to load files and understand how the file in the docker container maps to the local system
autocmd VimEnter * :call Vdebug_load_options( { 'path_maps' : { '/var/www/html/' : getcwd() } } )

" Sets up within word motions to use ,
let g:camelcasemotion_key = ','

let g:startify_lists = [ { 'type': 'dir', 'header': ['   Recent Files'] } ]

" Better indents
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

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

let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" Configure Airline Theme
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Fix netrw buffer issue
let g:netrw_fastbrowse = 0

"##############################################################################
" Custom Functions
"##############################################################################

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

" Creates a floating window with a most recent buffer to be used
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
    autocmd BufWipeout <buffer> call CleanupBuffer(s:buf)
    tnoremap <buffer> <silent> <Esc> <C-\><C-n><CR>:call DeleteUnlistedBuffers()<CR>
endfunction



"##############################################################################
" Terminal Handling
"##############################################################################

" Set login shell for :terminal command so aliases work
set shell=/usr/local/bin/bash

" When term starts, auto go into insert mode
autocmd TermOpen * startinsert

" Turn off line numbers etc
autocmd TermOpen * setlocal listchars= nonumber norelativenumber

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    else
        call DeleteUnlistedBuffers()
    endif
endfunction

" Open Project
function! ToggleProject()
    call ToggleTerm('tmuxinator-fzf-start.sh')
endfunction

function! ToggleScratchTerm()
    call ToggleTerm('bash')
endfunction

function! ToggleLazyGit()
    call ToggleTerm('lazygit')
endfunction

function! ToggleHarvest()
    call ToggleTerm('hstarti')
endfunction

function! OnTermExit(job_id, code, event) dict
    if a:code == 0
        call DeleteUnlistedBuffers()
    endif
endfunction

function! DeleteUnlistedBuffers()
    for n in nvim_list_bufs()
        if ! buflisted(n)
            let name = bufname(n)
            if name == '[Scratch]' ||
              \ matchend(name, ":bash") ||
              \ matchend(name, ":lazygit") ||
              \ matchend(name, ":tmuxinator-fzf-start.sh") ||
              \ matchend(name, ":hstarti")
                call CleanupBuffer(n)
            endif
        endif
    endfor
endfunction

function! CleanupBuffer(buf)
    if bufexists(a:buf)
        silent execute 'bwipeout! '.a:buf
    endif
endfunction

