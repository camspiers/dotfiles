"###############################################################################
"# Neovim Configuration (Cam Spiers) ###########################################
"###############################################################################
" See README.md for more information

" Install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Custom Vim Plug {{{
" Options for each plugin, helps improve readability of plugin registration
let g:vim_plug_opts = {
  \ 'glacambre/firenvim': has('nvim') ? {'do': { _ -> firenvim#install(0) } } : {'on': []},
  \ 'iamcco/markdown-preview.nvim': {'do': 'cd app & yarn install'},
  \ 'mbbill/undotree':              {'on': 'UndotreeToggle' },
  \ 'neoclide/coc.nvim':            {'do': { -> coc#util#install()} },
  \ 'vim-vdebug/vdebug':            {'on': []},
  \ 'dracula/vim':                  {'as': 'dracula'},
\ }

" Register plugin with options
function! Plug(plugin) abort
  let plugin = substitute(a:plugin, "'", '', 'g')
  call plug#(plugin, get(g:vim_plug_opts, plugin, {}))
endfunction
" }}}

" Plugins {{{
" Begin vim plug
call plug#begin(expand('~/.config/nvim/plugged'))

" Custom command for registering plugins, must follow plug#begin
command! -nargs=1 -bar Plug call Plug(<f-args>)

" Defaults {{{
Plug 'christoomey/vim-tmux-navigator' | " Pane navigation
Plug 'farmergreg/vim-lastplace'       | " Go to last position when opening files
Plug 'tpope/vim-sensible'             | " Sensible defaults
Plug 'wincent/terminus'               | " Terminal integration improvements
" }}}

" Search {{{
Plug 'jesseleite/vim-agriculture' | " Ripgrep options for FZF
Plug 'junegunn/fzf'               | " Main FZF plugin
Plug 'junegunn/fzf.vim'           | " Fuzzy finding plugin
" }}}

" Navigation {{{
Plug 'lambdalisue/fern.vim'                   | " Replacement for netrw
Plug 'lambdalisue/fern-renderer-devicons.vim' | " Dev icons for fern
Plug 'tpope/vim-projectionist'                | " Navigation of related files
Plug 'wincent/vcs-jump'                       | " Jump to git things
Plug 'ap/vim-buftabline'                      | " Displays buffers
" }}}

" Visual {{{
Plug 'arecarn/vim-clean-fold'          | " Provides function for folds
Plug 'blueyed/vim-diminactive'         | " Helps identifying active window
Plug 'camspiers/animate.vim'           | " Animation plugin
Plug 'camspiers/lens.vim'              | " Window resizing plugin
Plug 'dracula/vim'                     | " Dracula theme
Plug 'junegunn/goyo.vim'               | " Distraction free writing mode
Plug 'junegunn/limelight.vim'          | " Only syntax highlight current paragraph
Plug 'mhinz/vim-startify'              | " Startup screen
Plug 'nathanaelkane/vim-indent-guides' | " Provides indentation guides
Plug 'ryanoasis/vim-devicons'          | " Dev icons
Plug 'vim-scripts/folddigest.vim'      | " Visualize folds
Plug 'wincent/loupe'                   | " Search context improvements
" }}}

" Conquer of Completion {{{
Plug 'neoclide/coc.nvim' | " Completion provider
" }}}

" Editor {{{
Plug 'bkad/CamelCaseMotion'          | " Motions for inside camel case
Plug 'editorconfig/editorconfig-vim' | " Import tabs etc from editorconfig
Plug 'honza/vim-snippets'            | " A set of common snippets
Plug 'junegunn/vim-easy-align'       | " Helps alignment
Plug 'kkoomen/vim-doge'              | " Docblock generator
Plug 'lervag/vimtex'                 | " Support for vimtex
Plug 'matze/vim-move'                | " Move lines
Plug 'reedes/vim-pencil'             | " Auto hard breaks for text files
Plug 'romainl/vim-cool'              | " Awesome search highlighting
Plug 'terryma/vim-multiple-cursors'  | " Multiple cursor support like Sublime
Plug 'tomtom/tcomment_vim'           | " Better commenting
Plug 'tpope/vim-repeat'              | " Improves repeat handling
Plug 'tpope/vim-surround'            | " Surround motions
Plug 'wellle/targets.vim'            | " Move text objects
" }}}

" Tools {{{
Plug 'glacambre/firenvim'            | " Enables nvim in browser
Plug 'airblade/vim-rooter'           | " Auto-root setting
Plug 'dhruvasagar/vim-table-mode'    | " Better handling for tables in markdown
Plug 'duggiefresh/vim-easydir'       | " Create files in dirs that don't exist
Plug 'iamcco/markdown-preview.nvim'  | " Markdown preview
Plug 'inkarkat/vim-ingo-library'     | " Spellcheck dependency
Plug 'inkarkat/vim-spellcheck'       | " Spelling errors to quickfix list
Plug 'itchyny/calendar.vim'          | " Nice calendar app
Plug 'kassio/neoterm'                | " REPL integration
Plug 'kristijanhusak/vim-dadbod-ui'  | " DB UI support
Plug 'mbbill/undotree'               | " Undo history visualizer
Plug 'prashantjois/vim-slack'        | " Slack integration
Plug 'samoshkin/vim-mergetool'       | " Merge tool for git
Plug 'sedm0784/vim-you-autocorrect'  | " Automatic autocorrect
Plug 'shumphrey/fugitive-gitlab.vim' | " GitLab support
Plug 'tpope/vim-dadbod'              | " DB support
Plug 'tpope/vim-eunuch'              | " UNIX tools
Plug 'tpope/vim-fugitive'            | " Git tools
Plug 'tpope/vim-obsession'           | " Save sessions automatically
Plug 'tpope/vim-speeddating'         | " Tools for working with dates
Plug 'tpope/vim-unimpaired'          | " Common mappings for many needs
Plug 'vim-vdebug/vdebug'             | " Debugging, loaded manually
Plug 'wellle/tmux-complete.vim'      | " Completion for content in tmux
Plug 'rbong/vim-flog'                | " Commit viewer
" }}}

" Syntax {{{
Plug 'bfontaine/Brewfile.vim'          | " Brewfile
Plug 'phalkunz/vim-ss'                 | " SilverStripe templates
Plug 'reasonml-editor/vim-reason-plus' | " Reason support
Plug 'sheerun/vim-polyglot'            | " Lang pack
" }}}

" End the plugin registration
call plug#end()
" }}}

" Settings {{{

" General {{{
set clipboard=unnamed                | " System clipboard
set dictionary=/usr/share/dict/words | " Set up a dictionary
set encoding=UTF-8                   | " Default file encoding
set hidden                           | " Make buffers hidden then abandoned
set noautochdir                      | " Don't change dirs automatically
set noerrorbells                     | " No sound
set signcolumn=yes                   | " Show signcolumns
set splitbelow splitright            | " Split defaults
set undofile                         | " Enable undo persistence across sessions
set wildignore+=*.aux,*.out,*.toc    | " LaTeX
set wildignore+=*.orig               | " Merge files
set wildignore+=*.sw?                | " Vim swap files
set wildignore+=.DS_Store            | " OSX files
set wildignore+=.git,.hg             | " Version control files
" }}}

" Search {{{
set ignorecase         | " Ignores case in search
set smartcase          | " Overrides ignore when capital exists
if has('nvim')
  set inccommand=split | " Displays incremental replacement
endif
" }}}

" Editor {{{
set expandtab      | " Expand tab to spaces
set shiftwidth=2   | " Number of spaces for indentation
set spelllang=en   | " Spell checking
set tabstop=2      | " Number of spaces a <Tab> is
set timeoutlen=500 | " Wait less time for mapped sequences
" }}}

" Visual {{{
colorscheme dracula                         | " Sets theme to dracula
let &colorcolumn="81,121"                   | " Add indicator for 80 and 120
let base16colorspace=256                    | " Access colors present in 256 colorspace
set foldtext=clean_fold#fold_text_minimal() | " Clean folds
set noshowmode                              | " Don't show mode changes
set novisualbell                            | " Don't display visual bell
set nowrap                                  | " Don't wrap lines
set number relativenumber                   | " Show line numbers
set showmatch                               | " Show matching braces
set termguicolors                           | " Enables 24bit colors
" Highlight Customizations {{{
highlight Comment gui=italic,bold | " Make comments italic
" }}}
" }}}

" }}}

" Mappings {{{

" General {{{
" Save file
nnoremap <silent> <Leader>q :write<CR>
" Save and close
nnoremap <silent> <Leader><S-q> :x<CR>
" Easy align in visual mode
xmap     ga <Plug>(EasyAlign)
" Easy align in normal mode
nmap     ga <Plug>(EasyAlign)
" Open startify with leader s
nnoremap <silent> <Leader>s :Startify<CR>
" Open custom digest for folds
nnoremap <silent> <Leader>= :call CustomFoldDigest()<CR>
" Make BS/DEL work as expected in visual modes (i.e. delete the selected text)...
xmap <BS> x
" }}}

" Search {{{
" Open fuzzy files with leader \
nnoremap <silent> <Leader>\ :Files<CR>
" Open fuzzy lines with leader l
nnoremap <silent> <Leader>l :Lines<CR>
" Open fuzzy buffers with leader b
nnoremap <silent> <Leader>b :Buffers<CR>
" Open fuzzy windows with leader space
nnoremap <silent> <Leader>w :Windows<CR>
" Open ripgrep
nnoremap <silent> <Leader>f :Rg<CR>
" Open global ripgrep
nnoremap <silent> <Leader><S-f> :Rgg<CR>
" Open ripgrep agriculture
nmap <Leader>/ <Plug>RgRawSearch
" Open ripgrep agriculture for visual selection
vmap <Leader>/ <Plug>RgRawVisualSelection
" Remap ** to * now that we are using * for other bindings
nnoremap ** *
" Open ripgrep agriculture for cursor word
nmap */ <Plug>RgRawWordUnderCursor
" Open ripgrep for cursor word
nnoremap <silent> *f :Rg <C-R><C-W><CR>
" Open global ripgrep for cursor word
nnoremap <silent> *<S-f> :Rgg <C-R><C-W><CR>
" }}}

" Switching {{{
" Next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader><S-a> :AV<CR>
" }}}

" View Management {{{
" Open current file in fern
nnoremap <silent> - :Fern . -reveal=%<CR>
" Create vsplit
nnoremap <silent> <leader>\| :call Vsplit()<CR>
" Create hsplit
nnoremap <silent> <Leader>- :call Split()<CR>
" Only window
nnoremap <silent> <Leader>o :only<CR>
" Close the current buffer
nnoremap <silent> <Leader>c :close<CR>
" Close the current buffer
nnoremap <silent> <Leader><S-c> :%close<CR>
" Delete the current buffer
nnoremap <silent> <Leader>x :bdelete<CR>
" Delete the current buffer
nnoremap <silent> <Leader><S-x> :bdelete!<CR>
" Close all buffers
nnoremap <silent> <Leader>z :%bdelete<CR>
" Close all buffers
nnoremap <silent> <Leader><S-z> :%bdelete!<CR>
" Remap arrows to resize
nnoremap <silent> <Up>    :call animate#window_delta_height(15)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-15)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(30)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-30)<CR>
" Toggle clean
nnoremap <silent> <F1> :Clean<CR>
" }}}

" Conquer of Completion {{{
" Get outline
nnoremap <silent> <Leader>co :<C-u>CocList outline<CR>
" Get symbols
nnoremap <silent> <Leader>cs :<C-u>CocList -I symbols<CR>
" Get errors
nnoremap <silent> <Leader>cl :<C-u>CocList locationlist<CR>
" Get available commands
nnoremap <silent> <Leader>cc :<C-u>CocList commands<CR>
" Rename
nmap <Leader>$ <Plug>(coc-rename)
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
" Run :VcsJump diff
nnoremap <Leader>+ :VcsJump diff<CR>
" }}}

" Fuzzy Finder {{{
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

" Custom Tools {{{
if ! has('gui_running')
  " Open project
  nnoremap <silent> <Leader>] :call openterm#vertical('tmuxinator-fzf-start.sh', 0.2)<CR>
  " Switch session
  nnoremap <silent> <Leader>[ :call openterm#vertical('tmux-fzf-switch.sh', 0.2)<CR>
  " Kill session
  nnoremap <silent> <Leader>} :call openterm#vertical('tmux-fzf-kill.sh', 0.2)<CR>
  " Toggle pomodoro
  nnoremap <silent> <Leader>p :call TogglePomodoro()<CR>
endif
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call openterm#horizontal('lazygit', 0.8)<CR>
" Open lazydocker
nnoremap <silent> <Leader>; :call openterm#horizontal('lazydocker', 0.8)<CR>
" Open harvest
nnoremap <silent> <Leader>h :call openterm#horizontal('hstarti', 0.1)<CR>
" Open scratch pad
nnoremap <silent> <Leader>sc :call openterm#horizontal('bash', 0.2)<CR>
" Open calendar + todo
nnoremap <silent> <Leader>t :call OpenCalendar()<CR>
" Calls the custom start function that requests path map to be defined if not already run
nnoremap <silent> <F5> :call StartVdebug()<CR>
" }}}

" }}}

" Search Configuration {{{
" Use agriculture as a global no hidden search
let g:agriculture#rg_options = '--no-ignore --hidden'
" Some ripgrep searching defaults
function! RgCommand(ignore) abort
  return join([
    \ 'rg',
    \ '--hidden', '--color ansi', '--column',
    \ '--line-number', '--no-heading', '--smart-case',
    \ (a:ignore == 1 ? '--ignore' : '--no-ignore')
  \], ' ')
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
function! Rg(ignore, args, bang) abort
  let command = RgCommand(a:ignore).' '.shellescape(a:args)
  call fzf#vim#grep(command, 1, Preview(RgPreviewFlags(a:ignore ? 'Grep' : 'Global Grep')), a:bang)
  call animate#window_percent_height(0.8)
endfunction
" Defines search command for :Files
let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'
" Opens files search with preview
function! Files(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
  call animate#window_percent_height(0.5)
endfunction
" Opens lines with animation
function! Lines(args, bang) abort
  call fzf#vim#lines(a:args, a:bang)
  call animate#window_percent_height(0.8)
endfunction
" Opens buffers with animation
function! Buffers(args, bang) abort
  call fzf#vim#buffers(a:args, a:bang)
  call animate#window_percent_height(0.2)
endfunction
" Opens buffers with animation
function! Windows(bang) abort
  call fzf#vim#windows(a:bang)
  call animate#window_percent_height(0.2)
endfunction
" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = join(
  \ [
    \ '--layout=default',
    \ '--info inline',
    \ '--bind ' . join(
      \ [
        \ 'ctrl-a:select-all',
        \ 'ctrl-d:deselect-all',
        \ 'tab:toggle+up',
        \ 'shift-tab:toggle+down',
        \ 'ctrl-p:toggle-preview'
      \ ],
      \ ',',
    \ )
  \ ],
  \ ' ',
\ )
" Default location for FZF
let g:fzf_layout = {
 \ 'window': 'call NewFZFWindow()'
\ }

" Ctrl-l populates arglist. Use with :cfdo. Only works in :Files
let g:fzf_action = {
  \ 'ctrl-l': {l -> execute('args ' . join(map(l, {_, v -> fnameescape(v)}), ' '))},
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
\ }
" }}}

" Plugin Configuration {{{

" Fern {{{
let g:fern#renderer = "devicons"
let g:fern#default_hidden = 1
let g:fern#default_exclude = &wildignore
" }}}

" Buftabline {{{
let g:buftabline_indicators = 1
highlight BufTabLineCurrent guifg=#44475a guibg=#f8f8f2
highlight BufTabLineHidden guibg=#282a36
highlight BufTabLineActive guibg=#282a36
highlight BufTabLineFill guibg=#282a36
" }}}

" Vimtex {{{
let g:vimtex_view_method = 'skim'
" }}}

" Pencil {{{
let g:pencil#autoformat = 0
let g:pencil#textwidth = 80
let g:pencil#conceallevel = 0
" }}}

" Polyglot {{{
let g:polyglot_disabled = ['latex']
" }}}

" Table Mode {{{
let g:table_mode_corner = '|'
" }}}

" Firenvim {{{
let g:firenvim_config = { 'localSettings': { '.*': { 'takeover': 'never', } } }
" }}}

" Loupe {{{
let g:LoupeClearHighlightMap = 0
" }}}

" Conquer of Completion {{{

" Plugins {{{
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-pairs',
  \ 'coc-phpls',
  \ 'coc-prettier',
  \ 'coc-reason',
  \ 'coc-sh',
  \ 'coc-snippets',
  \ 'coc-stylelint',
  \ 'coc-tslint',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-vimtex',
  \ 'coc-yaml',
\ ]
" }}}

" CoC Related Settings {{{
" See coc-settings.json for more configuration
" Some servers have issues with backup files
set nobackup
set nowritebackup
" Remove messages from in-completion menus
set shortmess+=c
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" }}}

" CoC Colors {{{
highlight CocCodeLens gui=italic,bold guifg=#505050
" }}}

" Use tab for trigger completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" }}}

" Neoterm {{{

" Sets default location that neoterm opens
let g:neoterm_default_mod = 'botright'
let g:neoterm_autojump = 1
let g:neoterm_direct_open_repl = 1
" }}}

" Rooter {{{
" Use docker files and git
let g:rooter_patterns = ['docker-compose.yml', '.git/']
" Change silently
let g:rooter_silent_chdir = 1
" }}}

" Dim Inactive {{{
" Handle focus lost and gained events
let g:diminactive_enable_focus = 1
" Use color column to help with active/inactive
let g:diminactive_use_colorcolumn = 1
" }}}

" Merge Tool {{{
" 3-way merge
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'
" }}}

" Markdown Preview {{{
" Don't start markdown preview automatically, use :MarkdownPreview
let g:mkdp_auto_start = 0
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

" Indent Guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_color_change_percent = 1
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'fzf', 'openterm', 'neoterm', 'calendar']
" }}}

" Fold Digest {{{
let folddigest_options = "nofoldclose,vertical,flexnumwidth"
let folddigest_size = 40
" }}}

" Lens {{{
let g:lens#height_resize_min = 15
" }}}

" }}}

" Custom Tools {{{

" Enabled appropriate options for text files
function! EnableTextFileSettings() abort
  setlocal spell
  EnableAutocorrect
  silent TableModeEnable
  call pencil#init({'wrap': 'hard'})
endfunction

let g:distraction_free = 0
function! ToggleDistractionFreeSettings() abort
  if g:distraction_free
    call DisableDistractionFreeSettings()
  else
    call EnableDistractionFreeSettings()
  endif
endfunction
function! EnableDistractionFreeSettings() abort
  if g:distraction_free
    return
  endif
  let g:distraction_free = 1
  let g:lens#disabled = 1
  call goyo#execute(0, 0)
  Limelight
  let g:buftabline_show = 0
  call buftabline#update(0)
  set showtabline=0
  silent !tmux set status off
endfunction
function! DisableDistractionFreeSettings() abort
  if ! g:distraction_free
    return
  endif
  let g:distraction_free = 0
  let g:lens#disabled = 0
  call goyo#execute(0, 0)
  Limelight!
  set showtabline=1
  let g:buftabline_show = 2
  call buftabline#update(0)
  silent !tmux set status on
endfunction
" Opens calendar with animation
function! OpenCalendar() abort
  new | wincmd J | resize 1
  call animate#window_percent_height(0.8)
  call timer_start(300, {id -> execute('Calendar -position=here')})
endfunction
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
  if &virtualedit != "all"
    set virtualedit=all
  else
    set virtualedit=
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
    call RegisterVdebug()
    let g:register_vdebug = 1
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
" Opens FoldDigest with some default visual settings
function! CustomFoldDigest() abort
  call FoldDigest()
  call EnableCleanUI()
  vertical resize 1
  call animate#window_absolute_width(lens#get_cols())
  set winfixwidth
endfunction
" Creates a vsplit in an animated fashion
function! Vsplit() abort
  vsplit
  call NaturalVerticalDrawer()
endfunction
" Creates a split with animation
function! Split() abort
  split
  call NaturalDrawer()
endfunction
" Creates a drawer effect that respects the natural height
function! NaturalDrawer() abort
  let height = winheight(0)
  resize 1
  call animate#window_absolute_height(height)
endfunction
" Creates a drawer effect that respects the natural width
function! NaturalVerticalDrawer() abort
  let width = winwidth(0)
  vertical resize 1
  call animate#window_absolute_width(width)
endfunction

" Animate the quickfix and ensure it is at the bottom
function! OpenQuickFix() abort
  if getwininfo(win_getid())[0].loclist != 1
    wincmd J
  endif
  call NaturalDrawer()
endfunction

" Configures an FZF window
function! NewFZFWindow() abort
  new | wincmd J | resize 1
endfunction

" Enables UI styles suitable for terminals etc
function! EnableCleanUI() abort
  setlocal listchars=
    \ nonumber 
    \ norelativenumber
    \ nowrap
    \ winfixwidth
    \ laststatus=0
    \ noshowmode
    \ noruler
    \ scl=no
    \ colorcolumn=
  autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endfunction

" There's an issue with animating FZF. The preview sees the terminal as having
" a small height, and therefore doesn't render the preview with any lines
" this hack is to toggle the preview on and off, thereby rerendering the
" preview
function! RefreshFZFPreview() abort
  if has('nvim')
    if exists('g:last_open_term_id') && g:last_open_term_id
      call timer_start(350, {t->chansend(g:last_open_term_id, "\<C-p>\<C-p>")})
    endif
  else
    call term_sendkeys(bufnr('%'), "\<C-p>\<C-p>")
  endif
endfunction
" }}}

" Commands {{{

" CoC Format
command! -nargs=0 Format :call CocAction('format')
" Opens FZF + Ripgrep for not ignored files
command! -bang -nargs=* Rg call Rg(v:true, <q-args>, <bang>0)
" Opens FZF + Ripgrep for all files
command! -bang -nargs=* Rgg call Rg(v:false, <q-args>, <bang>0)
" Opens a file searcher
command! -bang -nargs=? -complete=dir Files call Files(<q-args>, <bang>0)
" Opens search of lines in open buffers
command! -bang -nargs=* Lines call Lines(<q-args>, <bang>0)
" Opens buffer search
command! -bar -bang -nargs=? -complete=buffer Buffers call Buffers(<q-args>, <bang>0)
" Opens window search
command! -bar -bang Windows call Windows(<bang>0)
" Sets up command for prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Custom Goyo
command! -nargs=0 Clean call ToggleDistractionFreeSettings()
" }}}

function! OnFZFOpen() abort
  call EnableCleanUI()
  call RefreshFZFPreview()
  tnoremap <Esc> <c-c>
  startinsert
endfunction

function! OnNeoTermOpen() abort
  call EnableCleanUI()
  wincmd J
  call NaturalDrawer()
endfunction

" Auto Commands {{{
augroup General
  autocmd!
  " Put the quickfix window always at the bottom
  autocmd! FileType qf call OpenQuickFix()
  " Enable text file settings
  autocmd! FileType markdown,txt,tex call EnableTextFileSettings()
  autocmd! FileType sh call neoterm#repl#set('sh')
  autocmd! FileType fern,floggraph call EnableCleanUI()
  autocmd! FileType neoterm call OnNeoTermOpen()
  autocmd! FileType fzf call OnFZFOpen()
  autocmd! VimLeavePre * call DisableDistractionFreeSettings()
augroup END

augroup TermHandling
  autocmd!
  if has('nvim')
    autocmd! TermOpen * let g:last_open_term_id = b:terminal_job_id
  endif
augroup END

" }}}

" vim:fdm=marker
