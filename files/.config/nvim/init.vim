"###############################################################################
"# Neovim Configuration (Cam Spiers) ###########################################
"###############################################################################
"
" This Neovim config is tailored towards PHP and JavaScript/TypeScript work
" it uses the vim-plug plugin manager and requires the following tools:
"
" - vim-plug
" - font with devicons
" - fzf
" - git
" - nvim
" - python3 support
" - ripgrep
" - tmux
" - yarn
"
"###############################################################################
"# Plugins #####################################################################
"###############################################################################

" Start vim plug and set the plugin directory
call plug#begin(stdpath('data') . '/plugged')

"###############################################################################
"# Vim Defaults Plugins ########################################################
"###############################################################################

" Sensible defaults
Plug 'tpope/vim-sensible'

" Standard terminal integration improvements
Plug 'wincent/terminus'

" Improves netrw
Plug 'tpope/vim-vinegar'

"###############################################################################
"# Visual Plugins ##############################################################
"###############################################################################

" Status line
Plug 'vim-airline/vim-airline'

" Startup screen
Plug 'mhinz/vim-startify'

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

Plug 'https://gitlab.com/protesilaos/tempus-themes-vim'

"###############################################################################
"# Navigation/Search Plugins ###################################################
"###############################################################################

" Fuzzy file finding
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

" Helps root switching
Plug 'airblade/vim-rooter'

" Cyclic navigation bindings for filetypes and file patterns
Plug 'tpope/vim-projectionist'

" Integrates with projectionist to add 'Ftype' type commands
Plug 'c-brenn/fuzzy-projectionist.vim'

" Common pane navigation for vim and tmux together
Plug 'christoomey/vim-tmux-navigator'

" Jump to interesting places with a Git or Mercurial repo
Plug 'wincent/vcs-jump'

"###############################################################################
"# Code Formatting Plugins #####################################################
"###############################################################################

" Import tabs etc from editorconfig
Plug 'editorconfig/editorconfig-vim'

" Vim prettier support
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

"###############################################################################
"# Editor/Motion Plugins #######################################################
"###############################################################################

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

" Better search motions (s and S)
Plug 'justinmk/vim-sneak'

"###############################################################################
"# Tool Plugins ################################################################
"###############################################################################

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

" Slack integration
Plug 'prashantjois/vim-slack'

" Live Latex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Allow the use of Nvim from Brave/Chrome
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" UNIX tools
Plug 'tpope/vim-eunuch'

" Term abstractions
Plug 'kassio/neoterm'

" Git tools
Plug 'tpope/vim-fugitive'

" DB tools
Plug 'tpope/vim-dadbod'

" [ and ] mappings, in particular for quickfix
Plug 'tpope/vim-unimpaired'

" Tool for seeing git messages in a line, and visual context
Plug 'rhysd/git-messenger.vim'

" Spelling errors to quickfix list
Plug 'inkarkat/vim-ingo-library' | Plug 'inkarkat/vim-spellcheck'

"###############################################################################
"# Syntax Plugins ##############################################################
"###############################################################################

Plug 'bfontaine/Brewfile.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'jwalton512/vim-blade'
Plug 'leafgarland/typescript-vim'
Plug 'lilyball/vim-swift'
Plug 'peitalin/vim-jsx-typescript'
Plug 'phalkunz/vim-ss'
Plug 'StanAngeloff/php.vim'
Plug 'tmux-plugins/vim-tmux'

call plug#end()

"###############################################################################
"# General Settings ############################################################
"###############################################################################

" Import local config for private config, e.g. keys, tokens
silent! source ~/.config/nvim/local.vim

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
set wildignore+=.git/,.DS_Store

" No sound
set noerrorbells
set timeoutlen=500

" Set up a dictionary
set dictionary=/usr/share/dict/words

"###############################################################################
"# Searching ###################################################################
"###############################################################################

set ignorecase
set smartcase

augroup IncSearchHighlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

"###############################################################################
"# Editing #####################################################################
"###############################################################################

set tabstop=4
set shiftwidth=4
set expandtab

"###############################################################################
"# Visual Settings #############################################################
"###############################################################################

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
set number relativenumber

" Set the colorscheme but don't error if dracula doesn't exist
silent! colorscheme tempus_classic

" Enables 24bit colors
set termguicolors

" Make comments italic
highlight Comment cterm=italic gui=italic

"###############################################################################
"# Mappings ####################################################################
"###############################################################################

" Only window
nnoremap <silent> <Leader>o :only<CR>
" Next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>
" Create vsplit
nnoremap <silent> <Leader>\| :vsplit<CR>
" Create hsplit
nnoremap <silent> <Leader>- :split<CR>
" Save file
nnoremap <silent> <Leader>w :w<CR>
" Open startify with leader s
nnoremap <silent> <Leader>s :Startify<CR>
" Open fuzzy files with leader \
nnoremap <silent> <Leader>\ :Files<CR>
" Open fuzzy lines with leader l
nnoremap <silent> <Leader>l :Lines<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>
" Open ripgrep
nnoremap <silent> <Leader>g :Rg<CR>
" Open global grep
nnoremap <silent> <Leader>/ :Rgg<CR>
" Open ripgrep for cursor word
nnoremap <silent> <Leader>c :Rg <C-R><C-W><CR>
" Close the current buffer
nnoremap <silent> <Leader>x :bdelete<CR>
" Close all buffers
nnoremap <silent> <Leader>z :%bd<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader>v :AV<CR>
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open project
nnoremap <silent> <Leader>m :call OpenProject()<CR>
" Open scratch term
nnoremap <silent> <Leader>t :call OpenScratchTerm()<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call OpenLazyGit()<CR>
" Open harvest
nnoremap <silent> <Leader>h :call OpenHarvest()<CR>
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
" Use gx{text-object} in normal mode
nmap gx <Plug>(neoterm-repl-send)
" Send selected contents in visual mode.
xmap gx <Plug>(neoterm-repl-send)
" Give a color scheme chooser
nnoremap <silent> <Leader>C :call fzf#run({
      \   'source':
      \     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
      \         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
      \   'sink':    'colo',
      \   'options': '+m',
      \   'left':    30
      \ })<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"###############################################################################
"# Commands ####################################################################
"###############################################################################

" Configures ripgrep with fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --color ansi --column --line-number --no-heading --smart-case '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': '--prompt="Grep> " --bind ctrl-a:select-all,ctrl-d:deselect-all --color=hl+:#8c9e3d,hl:#d2813d --delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* Rgg
  \ call fzf#vim#grep(
  \   'rg --color ansi --hidden --no-ignore --column --line-number --no-heading --smart-case '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': '--prompt="Global Grep> " --bind ctrl-a:select-all,ctrl-d:deselect-all --color=hl+:#8c9e3d,hl:#d2813d --delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"###############################################################################
"# Coc Configurations ##########################################################
"###############################################################################

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

"###############################################################################
"# Plugin Configurations #######################################################
"###############################################################################

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}

" 3-way merge
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'

" Config vim wiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" Don't start markdown preview automatically, use :MarkdownPreview
let g:mkdp_auto_start = 0

" Configures tmux line, use :TmuxlineSnapshot ~/.tmux/airline.conf to save
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#(whoami)',
      \'win'  : '#W',
      \'cwin' : '#W',
      \'z'    : ['%R', '%d', '%a', '%Y', '#(battstat {p} | tr -d " ")']}

let g:tmuxline_powerline_separators = 0

let g:indentLine_setConceal = 0

" Use docker files and git
let g:rooter_patterns = ['docker-compose.yml', '.git/']

" Change silently
let g:rooter_silent_chdir = 1

" Vdebug needs to be able to load files and understand how the file in the docker
" container maps to the local system
autocmd VimEnter * :call Vdebug_load_options( { 'path_maps' : { '/var/www/html/' : getcwd() } } )

" Sets up within word motions to use ,
let g:camelcasemotion_key = ','

let g:startify_lists = [ { 'type': 'dir', 'header': ['   Recent Files'] } ]

" Don't change directories
let g:startify_change_to_dir = 0

" Better indents
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Don't use status line in fzf
augroup FzfConfig
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'
let $FZF_DEFAULT_OPTS = '--layout=default' .
  \  ' --info inline' .
  \  ' --color gutter:#232323' .
  \  ' --color fg:#aeadaf' .
  \  ' --color bg:#232323' .
  \  ' --color fg+:#aeadaf' .
  \  ' --color bg+:#312e30' .
  \  ' --color hl:#d2813d' .
  \  ' --color hl+:#8c9e3d' .
  \  ' --color pointer:#d2813d' .
  \  ' --color info:#b58d88' .
  \  ' --color spinner:#949d9f' .
  \  ' --color header:#949d9f' .
  \  ' --color prompt:#6e9cb0' .
  \  ' --color marker:#d2813d'

let g:fzf_layout = { 'down': '~40%' }

" Configure Airline Theme
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }

" Fix netrw buffer issue
let g:netrw_fastbrowse = 0

"###############################################################################
"# Custom Functions ############################################################
"###############################################################################

" Cycle through relativenumber + number, number (only), and no numbering.
function! CycleLineNumbering() abort
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

" Toggle virtualedit
function! ToggleVirtualEdit() abort
  if &virtualedit == "all"
    set virtualedit=
  else
    set virtualedit=all
  endif
endfunction

"###############################################################################
"# Terminal Handling ###########################################################
"###############################################################################

let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1

" Quit term buffer with ESC
augroup TermHandling
  autocmd!
  " " Turn off line numbers etc
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
  autocmd TermOpen * tnoremap <Esc> <c-\><c-n>
  autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>
augroup END

" Open Project
function! OpenProject()
  :T clear && tmuxinator-fzf-start.sh && exit
endfunction

" Opens lazygit
function! OpenLazyGit()
  :T lazygit && exit
endfunction

" Opens harvest starti
function! OpenHarvest()
  :T clear && hstarti && exit
endfunction

