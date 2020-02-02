"###############################################################################
"# Neovim Configuration (Cam Spiers) ###########################################
"###############################################################################
" See README.md for more information
" Plugins {{{
" Start Vim plug and set the plugin directory
call plug#begin(stdpath('config') . '/plugged')
" Common command to install from lock file
let g:from_lock = {'do': 'yarn install --frozen-lockfile'}
" Defaults Plugins {{{
Plug 'tpope/vim-sensible' | " Sensible defaults
Plug 'wincent/terminus'   | " Terminal integration improvements
" }}}
" Visual Plugins {{{
Plug 'arecarn/vim-clean-fold'              | " Improves folds
Plug 'blueyed/vim-diminactive'             | " Makes determining active window easier
Plug 'chriskempson/base16-vim'             | " Themes
Plug 'edkolev/tmuxline.vim'                | " Makes tmux use airline colors
Plug 'mhinz/vim-signify'                   | " Show git info in sidebar
Plug 'mhinz/vim-startify'                  | " Startup screen
Plug 'nathanaelkane/vim-indent-guides'     | " Show indentation
Plug 'neoclide/coc-highlight', g:from_lock | " Displays hex colors in actual color
Plug 'psliwka/vim-smoothie'                | " Nicer scrolling
Plug 'ryanoasis/vim-devicons'              | " Dev icons
Plug 'vim-airline/vim-airline'             | " Airline
Plug 'vim-airline/vim-airline-themes'      | " Status line
" }}}
" Navigation/Search Plugins {{{
Plug '/usr/local/opt/fzf'             | " Brew version of FZF
Plug 'airblade/vim-rooter'            | " Auto-root setting
Plug 'christoomey/vim-tmux-navigator' | " Pane navigation
Plug 'fsharpasharp/vim-dirvinist'     | " Projections for dirvish
Plug 'jesseleite/vim-agriculture'     | " Rg options for FZF
Plug 'junegunn/fzf'                   | " Main FZF plugin
Plug 'junegunn/fzf.vim'               | " Fuzzy finding plugin
Plug 'justinmk/vim-dirvish'           | " Replacement for netrw
Plug 'kristijanhusak/vim-dirvish-git' | " Git statuses in dirvish
Plug 'romainl/vim-qf'                 | " Improves the quickfix list
Plug 'tpope/vim-projectionist'        | " Navigation of related files
Plug 'wincent/loupe'                  | " Search context improvements
Plug 'wincent/vcs-jump'               | " Jump to diffs
" }}}
" Editor/Motion Plugins {{{
" CoC Plugins {{{
Plug 'neoclide/coc.nvim',     { 'do': { -> coc#util#install()}}
Plug 'neoclide/coc-css',      g:from_lock | " CSS language server
Plug 'neoclide/coc-eslint',   g:from_lock | " Eslint integration
Plug 'neoclide/coc-html',     g:from_lock | " Html language server
Plug 'neoclide/coc-json',     g:from_lock | " JSON language server
Plug 'neoclide/coc-lists',    g:from_lock | " Arbitrary lists
Plug 'neoclide/coc-pairs',    g:from_lock | " Auto-insert language aware pairs
Plug 'neoclide/coc-snippets', g:from_lock | " Provides snippets
Plug 'neoclide/coc-tslint',   g:from_lock | " Tslint integration
Plug 'neoclide/coc-tsserver', g:from_lock | " TypeScript language server
" }}}
" General {{{
Plug 'AndrewRadev/splitjoin.vim' | " Split and join programming lines
Plug 'bkad/CamelCaseMotion'      | " Motions for inside camel case
Plug 'godlygeek/tabular'         | " Alignment for tables etc
Plug 'justinmk/vim-sneak'        | " Better search motions (s and S, z and Z)
Plug 'kkoomen/vim-doge'          | " Docblock generator
Plug 'romainl/vim-cool'          | " Awesome highlighting
Plug 'tomtom/tcomment_vim'       | " Better commenting
Plug 'tpope/vim-repeat'          | " Improves repeats handling of Vim plugins
Plug 'tpope/vim-surround'        | " Surround motions
" }}}
" }}}
" Code Formatting Plugins {{{
Plug 'editorconfig/editorconfig-vim'      | " Import tabs etc from editorconfig
Plug 'neoclide/coc-prettier', g:from_lock | " Prettier for COC
" }}}
" Tool Plugins {{{
Plug 'dstein64/vim-startuptime'        | " Measure startuptime
Plug 'duggiefresh/vim-easydir'         | " Crete files in dirs that don't exist
Plug 'inkarkat/vim-ingo-library'       | " Spellcheck dependency
Plug 'inkarkat/vim-spellcheck'         | " Spelling errors to quickfix list
Plug 'junegunn/vim-peekaboo'           | " Peak at registers
Plug 'kassio/neoterm'                  | " REPL integration
Plug 'kshenoy/vim-signature'           | " Tools for working with marks
Plug 'noahfrederick/vim-composer'      | " Adds composer command support
Plug 'prashantjois/vim-slack'          | " Slack integration
Plug 'rhysd/git-messenger.vim'         | " See git messages
Plug 'samoshkin/vim-mergetool'         | " Merge tool for git
Plug 'shumphrey/fugitive-gitlab.vim'   | " GitLab support
Plug 'skanehira/docker-compose.vim'    | " Docker compose tools
Plug 'tpope/vim-dadbod'                | " DB tools
Plug 'tpope/vim-eunuch'                | " UNIX tools
Plug 'tpope/vim-fugitive'              | " Git tools
Plug 'tpope/vim-unimpaired'            | " Common mappings for many needs
Plug 'vim-vdebug/vdebug', { 'on': [] } | " Debugging, loaded manually
Plug 'vimwiki/vimwiki'                 | " Personal wiki
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }                   | " Live Latex
Plug 'iamcco/markdown-preview.nvim',  { 'do': 'cd app & yarn install'  } | " Markdown preview
" }}}
" Syntax Plugins {{{
Plug 'bfontaine/Brewfile.vim'      | " Syntax for Brewfile
Plug 'ekalinin/dockerfile.vim'     | " Syntax for Dockerfile
Plug 'jwalton512/vim-blade'        | " Syntax for blade templates
Plug 'leafgarland/typescript-vim'  | " Syntax for typescript
Plug 'lilyball/vim-swift'          | " Syntax for swift
Plug 'peitalin/vim-jsx-typescript' | " Syntax for typescript jsx, .tsx
Plug 'phalkunz/vim-ss'             | " Syntax for SilverStripe templates
Plug 'StanAngeloff/php.vim'        | " Syntax for PHP
Plug 'tmux-plugins/vim-tmux'       | " Syntax for Tmux conf files
" }}}
call plug#end()
" }}}
" General Settings {{{
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
" }}}
" Search Settings {{{
set ignorecase
set smartcase
" Displays incremental replacement without actually replacing content
set inccommand=split
" }}}
" Edit Settings {{{
set tabstop=4
set shiftwidth=4
set expandtab
" }}}
" Visual Settings {{{
" Clean folds
set foldtext=clean_fold#fold_text_minimal()
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
highlight Comment gui=italic
" }}}
" Mappings {{{
" Navigation/Layout {{{
" General {{{
" Open startify with leader s
nnoremap <silent> <Leader>s :Startify<CR>
" }}}
" Search {{{
" Open fuzzy files with leader \
nnoremap <silent> <Leader>\ :Files<CR>
" Open fuzzy lines with leader l
nnoremap <silent> <Leader>l :Lines<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>
" Open ripgrep
nnoremap <silent> <Leader>f :Rg<CR>
" Open global grep
nnoremap <silent> <Leader>g :Rgg<CR>
" Open ripgrep for cursor word
nnoremap <silent> <Leader>c :Rg <C-R><C-W><CR>
" }}}
" Specialized Search {{{
" Open ripgrep agriculture
nmap <Leader>/ <Plug>RgRawSearch
" Open ripgrep agriculture for visual selection
vmap <Leader>/ <Plug>RgRawVisualSelection
" Open ripgrep agriculture for cursor word
nmap <Leader>* <Plug>RgRawWordUnderCursor
" }}}
" Switch Pane {{{
" Next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader>v :AV<CR>
" }}}
" Create Pane {{{
" Create vsplit
nnoremap <silent> <Leader>\| :vsplit<CR>
" Create hsplit
nnoremap <silent> <Leader>- :split<CR>
" }}}
" Close {{{
" Only window
nnoremap <silent> <Leader>o :only<CR>
" Close all by current window
nnoremap <silent> <Leader>o <C-w>o<CR>
" Close the current buffer
nnoremap <silent> <Leader>x :bdelete<CR>
" Close all buffers
nnoremap <silent> <Leader>z :%bdelete<CR>
" }}}
" Resize {{{
" Remap arrows to resize
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
" }}}
" }}}
" General {{{
" Save file
nnoremap <silent> <Leader>w :write<CR>
" }}}
" Custom Tools {{{
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open project
nnoremap <silent> <Leader>] :call OpenTerm('tmuxinator-fzf-start.sh', 0.15, 'vertical')<CR>
" Switch session
nnoremap <silent> <Leader>[ :call OpenTerm('tmux-fzf-switch.sh', 0.15, 'vertical')<CR>
" Kill session
nnoremap <silent> <Leader>} :call OpenTerm('tmux-fzf-kill.sh', 0.15, 'vertical')<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call OpenTerm('lazygit', 0.8)<CR>
" Open lazydocker
nnoremap <silent> <Leader>; :call OpenTerm('lazydocker', 0.8)<CR>
" Open harvest
nnoremap <silent> <Leader>h :call OpenTerm('hstarti', 0.1)<CR>
" Toggle pomodoro
nnoremap <silent> <Leader>p :call TogglePomodoro()<CR>
" Register Vdebug only need to call this when you need to change the roots
nnoremap <silent> <Leader>~ :call RegisterVdebug()<CR>
" Calls the custom start function that requests path map to be defined if not already run
nnoremap <silent> <F5> :call StartVdebug()<CR>
" }}}
" CoC {{{
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
" Get hint
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>
" }}}
" Neoterm {{{
" Use gx{text-object} in normal mode
nmap gx <Plug>(neoterm-repl-send)
" Send selected contents in visual mode.
xmap gx <Plug>(neoterm-repl-send)
" }}}
" Git {{{
" Git commit messages
nmap <silent> gm <Plug>(git-messenger)
" Run :VcsJump diff
nnoremap <Leader>+ :VcsJump diff<CR>
" }}}
" FZF {{{
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}
" }}}
" Navigation/Search Configuration {{{
" Use agriculture as a global no hidden search
let g:agriculture#rg_options = '--no-ignore --hidden'

" Some ripgrep searching defaults
function! RgCommand(ignore) abort
  return 'rg' .
    \ ' --hidden' .
    \ ' --color ansi' .
    \ ' --column' .
    \ ' --line-number' .
    \ ' --no-heading' .
    \ ' --smart-case' .
    \ ' ' . (a:ignore == 1 ? '--ignore' : '--no-ignore')
endfunction

" Adds prompt
function! PreviewFlags(prompt) abort
  return ' --prompt="' . a:prompt . '> "'
endfunction

" Ensure that only the 4th column delimited by : is filtered by FZF
function! RgPreviewFlags(prompt) abort
  return PreviewFlags(a:prompt) . ' --delimiter : --nth 4..'
endfunction

" Configs the preview
function! Preview(flags) abort
  return fzf#vim#with_preview({'options': a:flags})
endfunction

" Executes ripgrep with a preview
function! RgWithPreview(ignore, args, prompt, bang) abort
  let command = RgCommand(a:ignore).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:prompt)), a:bang)
endfunction

" Defines search command for :Files
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'
" Opens files search with preview
function! FilesWithPreview(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
endfunction

" Configures ripgrep with FZF, Rg for ignore, Rgg for no ignore, and Files
command! -bang -nargs=* Rg call RgWithPreview(v:true, <q-args>, 'Grep', <bang>0)
command! -bang -nargs=* Rgg call RgWithPreview(v:false, <q-args>, 'Global Grep', <bang>0)
command! -bang -nargs=? -complete=dir Files call FilesWithPreview(<q-args>, <bang>0)

" Don't use status line in FZF
augroup FzfConfig
  autocmd!
  autocmd! FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = '--layout=default' .
  \ ' --info inline' .
  \ ' --bind ctrl-a:select-all,ctrl-d:deselect-all,tab:toggle+up,shift-tab:toggle+down'

" Default location for FZF
let g:fzf_layout = { 'down': '~40%' }

" Ctrl-l populates arglist. Use with :cfdo. Only works in :Files
let g:fzf_action = {
  \ 'ctrl-l': {l -> execute('args ' . join(map(l, {_, v -> fnameescape(v)}), ' '))},
  \ }
" }}}
" Coc Configuration {{{
" See coc-settings.json for more configuration
" Sets up comand for prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Remove messages from in-completion menus
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Use tab for trigger completion
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" }}}
" Plugin Configuration {{{
" Git Messenger {{{
" Go into popup when gm is triggered
let g:git_messenger_always_into_popup = 1
" Better background color
hi link gitmessengerPopupNormal CursorLine
" Don't use default mappings
let g:git_messenger_no_default_mappings = 1
" }}}
" Dim Inactive {{{
" Handle focus lost and gained events
let g:diminactive_enable_focus = 1
" Use color column to help with active/inactive
let g:diminactive_use_colorcolumn = 1
" }}}
" Merge {{{
" 3-way merge
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'
" }}}
" Vimwiki {{{
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
" }}}
" MarkdownPreview {{{
" Don't start markdown preview automatically, use :MarkdownPreview
let g:mkdp_auto_start = 0
" }}}
" Tmuxline {{{
" Configures tmux line, use :TmuxlineSnapshot ~/.tmux/theme.conf to save
let g:tmuxline_preset = {
  \'a'    : '#[bold]#S',
  \'b'    : '#(whoami)',
  \'win'  : '#W',
  \'cwin' : '#W',
  \'y'    : ['%R', '%a', '%d/%m/%y'],
  \'z'    : '#[bold]#(battstat {p} | tr -d " ")'}
" Don't show powerline separators in tmuxline
let g:tmuxline_powerline_separators = 0
" }}}
" Rooter {{{
" Use docker files and git
let g:rooter_patterns = ['docker-compose.yml', '.git/']
" Change silently
let g:rooter_silent_chdir = 1
" }}}
" Camelcase Motion {{{
" Sets up within word motions to use ,
let g:camelcasemotion_key = ','
" }}}
" Startify {{{
" Changes startify to have a different heading and only dirs
let g:startify_lists = [ { 'type': 'dir', 'header': ['   Recent Files'] } ]
" Don't change directories
let g:startify_change_to_dir = 0
" }}}
" Indent guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 1
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" }}}
" Dirvish {{{
let g:dirvish_git_modified = 'guifg=#ddb26f ctermfg=3'
let g:dirvish_git_added = 'guifg=#acc267 ctermfg=2'
let g:dirvish_git_unmerged = 'guifg=#fb9fb1 ctermfg=1'
silent execute 'hi default DirvishGitModified '.g:dirvish_git_modified
silent execute 'hi default DirvishGitStaged '.g:dirvish_git_added
silent execute 'hi default DirvishGitRenamed '.g:dirvish_git_modified
silent execute 'hi default DirvishGitUnmerged '.g:dirvish_git_unmerged
silent execute 'hi default DirvishGitIgnored guifg=NONE guibg=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=NONE'
silent execute 'hi default DirvishGitUntracked guifg=NONE guibg=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=NONE'
silent execute 'hi default link DirvishGitUntrackedDir DirvishPathTail'
" }}}
" }}}
" Custom Tools {{{
" Cycle through relativenumber + number, number (only), and no numbering.
function! CycleLineNumbering() abort
  execute {
    \ '00': 'set relativenumber   | set number',
    \ '01': 'set norelativenumber | set number',
    \ '10': 'set norelativenumber | set nonumber',
    \ '11': 'set norelativenumber | set number' }[&number . &relativenumber]
endfunction

" Toggle virtualedit
function! ToggleVirtualEdit() abort
  if &virtualedit == "all"
    set virtualedit=
  else
    set virtualedit=all
  endif
endfunction

" Pomodoro timer, example: "25 5 25 5" will run a timer for 25mins, ding then
" 5mins, ding, then 25mins ding, then 5mins, ding
function! TogglePomodoro() abort
  call inputsave()
  let time = input("Units> ")
  call inputrestore()
  normal :<ESC>
  if time == ""
    silent execute "!vim-timer stop"
  else
    " Don't listen to hang up signal and background, basic daemonization
    call system("nohup vim-timer " . time . " &")
  endif
endfunction

" Start Vdebug and request pathmap if not yet set
let g:register_vdebug = 0
function! StartVdebug() abort
  if g:register_vdebug == 0
    call RegisterVdebug() | let g:register_vdebug = 1
  endif
  python3 debugger.run()
endfunction

" Vdebug needs to be able to load files and understand how the file in the docker
function! RegisterVdebug() abort
  call plug#load('vdebug')
  call inputsave()
  let server_root = input("Server Path> ", '/var/www/html/')
  let local_root = input("Local Path> ", getcwd())
  call inputrestore()
  normal :<ESC>
  let g:vdebug_options.path_maps[server_root] = local_root
endfunction
" }}}
" Terminal Handling {{{
" Sets default location that neoterm opens
let g:neoterm_default_mod = 'botright'

" Quit term buffer with ESC
augroup TermHandling
  autocmd!
  " Turn off line numbers, listchars, auto enter insert mode and map esc to
  " exit insert mode
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
    \ | startinsert
    \ | tnoremap <Esc> <c-\><c-n>
    \ | IndentGuidesDisable
  autocmd TermClose * IndentGuidesEnable
  autocmd FileType fzf tnoremap <buffer> <Esc> <c-c>
augroup END

" Open autoclosing terminal, with optional size and orientation
function! OpenTerm(cmd, ...) abort
  let percentage = get(a:, 1, 0.5)
  let orientation = get(a:, 2, 'horizontal')
  if orientation == 'horizontal'
    new | execute 'resize ' . string(&lines * percentage)
  else
    vnew | execute 'vertical resize ' . string(&columns * percentage)
  endif
  call termopen(a:cmd, {'on_exit': {j,c,e -> execute('if c == 0 | close | endif')}})
endfunction
" }}}
" vim:fdm=marker
