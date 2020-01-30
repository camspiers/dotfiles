"###############################################################################
"# Neovim Configuration (Cam Spiers) ###########################################
"###############################################################################
"
" This Neovim config is tailored towards PHP and JavaScript/TypeScript work
" it uses the vim-plug plugin manager and requires the following tools:
"
" | Tool                    | Description                                    |
" | ----------------------- | ----------------------                         |
" | Neovim                  | Untested in Vim                                |
" | vim-plug                | Plugin Manger                                  |
" | Yarn                    | Required by Plugins                            |
" | Git                     | Required by Plugins                            |
" | python3 support         | Required by Plugins                            |
" | font with devicons      | Devicons in statusline                         |
" | Fuzzy Finder (fzf)      | Search                                         |
" | ripgrep                 | Search                                         |
" | bat                     | Search Previews                                |
" | tmux                    | Open Projects                                  |
" | tmuxinator              | Open Projects                                  |
" | tmuxinator-fzf-start.sh | Open Projects                                  |
" | timer                   | Pomodoro timer (https://github.com/rlue/timer) |
"
"###############################################################################
"# Plugins #####################################################################
"###############################################################################

" Start Vim plug and set the plugin directory
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
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

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

" Themes
Plug 'chriskempson/base16-vim'

" Makes determining active window easier
Plug 'blueyed/vim-diminactive'

"###############################################################################
"# Navigation/Search Plugins ###################################################
"###############################################################################

" Fuzzy file finding, relies on fzf being installed via brew
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

" Allows the use of Rg options in Rg + FZF searching
Plug 'jesseleite/vim-agriculture'

" Helps root switching
Plug 'airblade/vim-rooter'

" Cyclic navigation bindings for filetypes and file patterns
Plug 'tpope/vim-projectionist'

" Integrates with projectionist to add 'Ftype' type commands
Plug 'c-brenn/fuzzy-projectionist.vim'

" Common pane navigation for Vim and tmux together
Plug 'christoomey/vim-tmux-navigator'

" Jump to interesting places with a Git or Mercurial repo
Plug 'wincent/vcs-jump'

" Search context improvements
Plug 'wincent/loupe'

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

" Better search motions (s and S, z and Z)
Plug 'justinmk/vim-sneak'

" Highlighting
Plug 'romainl/vim-cool'

"###############################################################################
"# Tool Plugins ################################################################
"###############################################################################

" Peak at registers
Plug 'junegunn/vim-peekaboo'

" Measure startuptime
Plug 'dstein64/vim-startuptime'

" Adds composer command support
Plug 'noahfrederick/vim-composer'

" Docker compose tools
Plug 'skanehira/docker-compose.vim'

" Personal wiki
Plug 'vimwiki/vimwiki'

" PHP Debugging
Plug 'vim-vdebug/vdebug', { 'on': [] }

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

" [ and ] mappings, in particular for quickfix, and spell nospell
Plug 'tpope/vim-unimpaired'

" Tool for seeing git messages in a line, and visual context
Plug 'rhysd/git-messenger.vim'

" Spelling errors to quickfix list
Plug 'inkarkat/vim-ingo-library' | Plug 'inkarkat/vim-spellcheck'

" When creating new files in directories that don't exist, it just works
Plug 'duggiefresh/vim-easydir'

" Tools for working with marks
Plug 'kshenoy/vim-signature'

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

" Make buffers hidden then abandoned
set hidden

"###############################################################################
"# Searching ###################################################################
"###############################################################################

set ignorecase
set smartcase

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

" Set the colorscheme
let base16colorspace=256
colorscheme base16-chalk
let g:airline_theme='base16_chalk'

" Enables 24bit colors
set termguicolors

" Make comments italic
highlight Comment cterm=italic gui=italic

"###############################################################################
"# Search Mappings #############################################################
"###############################################################################

"###############################################################################
"# Preview without Rg options | Daily Driver ###################################
"###############################################################################

" Open ripgrep
nnoremap <silent> <Leader>f :Rg<CR>
" Open global grep
nnoremap <silent> <Leader>g :Rgg<CR>
" Open ripgrep for cursor word
nnoremap <silent> <Leader>c :Rg <C-R><C-W><CR>

"###############################################################################
"# No Preview with Rg options | Specialized ####################################
"###############################################################################

" Open ripgrep agriculture
nmap <Leader>/ <Plug>RgRawSearch
" Open ripgrep agriculture for visual selection
vmap <Leader>/ <Plug>RgRawVisualSelection
" Open ripgrep agriculture for cursor word
nmap <Leader>* <Plug>RgRawWordUnderCursor

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
" Open lazygit
nnoremap <silent> <Leader>' :call OpenLazyGit()<CR>
" Open lazydocker
nnoremap <silent> <Leader>; :call OpenLazyDocker()<CR>
" Open harvest
nnoremap <silent> <Leader>h :call OpenHarvest()<CR>
" Toggle pomodoro
nnoremap <silent> <Leader>p :call TogglePomodoro()<CR>
" Register Vdebug
nnoremap <silent> <Leader>~ :call RegisterVdebug()<CR>
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
" Rename
nmap <leader>rn <Plug>(coc-rename)
" Go to definition
nmap gd <Plug>(coc-definition)
" Go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Go to references
nmap <silent> gr <Plug>(coc-references)
" Go to type
nmap <silent> gy <Plug>(coc-type-definition)
" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Git commit messages
nmap <silent> gm <Plug>(git-messenger)
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

" Remap arrows to resize
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

"###############################################################################
"# FZF/Ripgrep Configuration ###################################################
"###############################################################################

" Use agriculture as a global no hidden search
let g:agriculture#rg_options = '--no-ignore --hidden'

" Some ripgrep searching defaults
function! GetRipgrepCommand(ignore)
  if a:ignore == 1
      let ignoreFlag = '--ignore'
  else
      let ignoreFlag = '--no-ignore'
  endif

  return 'rg' .
    \ ' --hidden' .
    \ ' --color ansi' .
    \ ' --column' .
    \ ' --line-number' .
    \ ' --no-heading' .
    \ ' --smart-case' .
    \ ' ' . ignoreFlag
endfunction

" Restore appropriate colors, add prompt and bind ctrl-a and ctrl-d
function! GetPreviewFlags(prompt)
  return ' --prompt="' . a:prompt . '> "'
endfunction

" Ensure that only the 4th column delimited by : is filtered by FZF
function! GetGrepPreviewFlags(prompt)
  return GetPreviewFlags(a:prompt) . ' --delimiter : --nth 4..'
endfunction

" Configures ripgrep with fzf
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   GetRipgrepCommand(1) . ' ' . shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': GetGrepPreviewFlags('Grep')}), <bang>0)

command! -bang -nargs=* Rgg
  \ call fzf#vim#grep(
  \   GetRipgrepCommand(0) . ' ' . shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'options': GetGrepPreviewFlags('Global Grep')}), <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': GetPreviewFlags('Files')}), <bang>0)

" Don't use status line in fzf
augroup FzfConfig
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Use ripgrep for fzf
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'

" Color FZF with tempus classic
let $FZF_DEFAULT_OPTS = '--layout=default' .
  \ ' --info inline' .
  \ ' --bind ctrl-a:select-all,ctrl-d:deselect-all'

let g:fzf_layout = { 'down': '~40%' }

"###############################################################################
"# Coc Configuration ###########################################################
"###############################################################################

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

" Go into popup when gm is triggered
let g:git_messenger_always_into_popup = 1

" Better background color
hi link gitmessengerPopupNormal CursorLine

" Don't use default mappings
let g:git_messenger_no_default_mappings = 1

" Handle focus lost and gained events
let g:diminactive_enable_focus = 1

" Use color column to help with active/inactive
let g:diminactive_use_colorcolumn = 1

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
      \'a'    : '#[bold]#S',
      \'b'    : '#(whoami)',
      \'win'  : '#W',
      \'cwin' : '#W',
      \'y'    : ['%R', '%a', '%d/%m/%y'],
      \'z'    : '#[bold]#(battstat {p} | tr -d " ")'}

let g:tmuxline_powerline_separators = 0

let g:indentLine_setConceal = 0

" Use docker files and git
let g:rooter_patterns = ['docker-compose.yml', '.git/']

" Change silently
let g:rooter_silent_chdir = 1

" Sets up within word motions to use ,
let g:camelcasemotion_key = ','

let g:startify_lists = [ { 'type': 'dir', 'header': ['   Recent Files'] } ]

" Don't change directories
let g:startify_change_to_dir = 0

" Better indents
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" Configure Airline Theme
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Include the mode map so this file doesn't get treated as binary
source ~/.config/nvim/airline-mode-map.vim

" Fix netrw buffer issue
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3

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

" Pomodoro timer
function! TogglePomodoro()
  call inputsave()
  let time = input("Units> ")
  call inputrestore()
  normal :<ESC>
  if time == ""
    silent execute "!vim-timer stop"
  else
    call system("nohup vim-timer " . time . " &")
  endif
endfunction

" Vdebug needs to be able to load files and understand how the file in the docker
function! RegisterVdebug()
  call plug#load('vdebug')
  call inputsave()
  let root = input("Root> ", getcwd())
  call inputrestore()
  normal :<ESC>
  call Vdebug_load_options( { 'path_maps' : { '/var/www/html/' : expand(root) } } )
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

" Opens lazydocker
function! OpenLazyDocker()
  :T lazydocker && exit
endfunction

" Opens harvest starti
function! OpenHarvest()
  :T clear && hstarti && exit
endfunction
