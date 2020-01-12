"################################################################################
"# Neovim Configuration
"################################################################################
"
" This Neovim config is tailored towards PHP and JavaScript/TypeScript work
" it uses the vim-plug plugin manager and requires the following tools:
"
" - vim-plug
" - Font with devicons
" - fzf
" - git
" - nvim
" - python3 support
" - ripgrep
" - tmux
" - yarn

"################################################################################
"# Plugins
"################################################################################

call plug#begin(stdpath('data') . '/plugged')

"################################################################################
"# Vim Defaults Plugins
"################################################################################

" Sensible defaults
Plug 'tpope/vim-sensible'

" Standard terminal integration improvements
Plug 'wincent/terminus'

" Improves netrw
Plug 'tpope/vim-vinegar'

"################################################################################
"# Visual Plugins
"################################################################################

" Status line
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

" Startup screen
Plug 'mhinz/vim-startify'

" Nice theme, use this theme with terminal too
Plug 'arcticicestudio/nord-vim'

" Theme packs
Plug 'rafi/awesome-vim-colorschemes' | Plug 'xolox/vim-misc'

" No distraction mode
Plug 'junegunn/goyo.vim'

" Makes tmux use airline colors
Plug 'edkolev/tmuxline.vim'

" Show git info in sidebar
Plug 'mhinz/vim-signify'

" Dev icons
Plug 'ryanoasis/vim-devicons'

" Nicer scrolling
Plug 'psliwka/vim-smoothie'

" Show indentation
Plug 'Yggdroot/indentLine'

" Toggle relative line numbering <Leader>r
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"################################################################################
"# Navigation/Search Plugins
"################################################################################

" Fuzzy file finding
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Helps root switching
Plug 'airblade/vim-rooter'

" Cyclic navigation bindings for filetypes and file patterns
Plug 'tpope/vim-projectionist'

" Integrates with projectionist to add 'Ftype' type commands
Plug 'c-brenn/fuzzy-projectionist.vim'

" File browser
Plug 'vifm/vifm.vim'

" Common pane navigation for vim and tmux together
Plug 'christoomey/vim-tmux-navigator'

" Allows Rg to populate the quickfix list
Plug 'jremmen/vim-ripgrep'

" Jump to interesting places with a Git or Mercurial repo
Plug 'wincent/vcs-jump'

"################################################################################
"# Code Formatting Plugins
"################################################################################

" Import tabs etc from editorconfig
Plug 'editorconfig/editorconfig-vim'

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

"################################################################################
"# Editor/Motion Plugins
"################################################################################

" Coc
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}

" Better commenting
Plug 'tomtom/tcomment_vim'

" Find and replace via quickfix list
Plug 'stefandtw/quickfix-reflector.vim'

" Surround motions
Plug 'tpope/vim-surround'

" Adds ability to adjust alignment in visual mode
Plug 'godlygeek/tabular'

" Motions for inside camel case
Plug 'bkad/CamelCaseMotion'

" Allows repeating of various custom commands
Plug 'tpope/vim-repeat'

" Allows for easy repeat of last used macro
Plug 'wincent/replay'

" Split and join programming lines
Plug 'AndrewRadev/splitjoin.vim'

" Nice docblock generator
Plug 'kkoomen/vim-doge'

"################################################################################
"# Tool Plugins
"################################################################################

" Adds composer command support
Plug 'noahfrederick/vim-composer'

" Docker compose tools
Plug 'skanehira/docker-compose.vim'

" Personal wiki
Plug 'vimwiki/vimwiki'

" PHP Debugging
Plug 'vim-vdebug/vdebug'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Merge tool for git
Plug 'samoshkin/vim-mergetool'

"################################################################################
"# Syntax Plugins
"################################################################################

Plug 'bfontaine/Brewfile.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lilyball/vim-swift'
Plug 'peitalin/vim-jsx-typescript'
Plug 'StanAngeloff/php.vim'
Plug 'phalkunz/vim-ss'
Plug 'tmux-plugins/vim-tmux'
Plug 'jwalton512/vim-blade'
Plug 'ekalinin/dockerfile.vim'

call plug#end()

"################################################################################
"# General Settings
"################################################################################

" Default file encoding
set encoding=UTF-8

" Enable undo persistence across sessions
set undofile

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

"################################################################################
"# Searching
"################################################################################

set ignorecase
set smartcase

augroup IncSearchHighlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

"################################################################################
"# Editing
"################################################################################

set tabstop=4
set shiftwidth=4
set expandtab

"################################################################################
"# Visual Settings
"################################################################################

" Add bulk color past 120
let &colorcolumn=join(range(121,999),",")

" Spell checking
set spelllang=en

" Turn spelling on for markdown files
autocmd FileType markdown setlocal spell

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

" Set the colorscheme but don't error if nord doesn't exist
silent! colorscheme nord
" Other themes I like:
" - carbonized-light
" - deep-space
" - github
" - hybrid-material
" - materialbox

" Enables 24bit colors
set termguicolors

" Give floating windows transparency
set winblend=30

" Make comments italic
highlight Comment cterm=italic gui=italic

"################################################################################
"# Mappings
"################################################################################

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
" Merge tool
nmap <leader>mt <plug>(MergetoolToggle)
" Give a color scheme chooser
nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

"################################################################################
"# Commands
"################################################################################

" Configures ripgrep with fzf
command! -bang -nargs=* FzfRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rgg call fzf#vim#grep("rg --no-ignore --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Allow Ripgrep to work with quick list
command! -nargs=* -complete=file Ripgrep :call s:Rg(<q-args>)
command! -nargs=* -complete=file Rg :call s:Rg(<q-args>)


"################################################################################
"# Coc Configurations
"################################################################################

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

"################################################################################
"# Plugin Configurations
"################################################################################

" 3-way merge
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'

" Config vim wiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

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
if exists("Vdebug_load_options")
	autocmd VimEnter * :call Vdebug_load_options( { 'path_maps' : { '/var/www/html/' : getcwd() } } )
endif

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

"################################################################################
"# Custom Functions
"################################################################################

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

"################################################################################
"# Terminal Handling
"################################################################################

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

" Opens a throwaway/scratch terminal
function! ToggleScratchTerm()
    call ToggleTerm('bash')
endfunction

" Opens lazygit
function! ToggleLazyGit()
    call ToggleTerm('lazygit')
endfunction

" Opens harvest starti
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

