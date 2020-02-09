"###############################################################################
"# Neovim Configuration (Cam Spiers) ###########################################
"###############################################################################
" See README.md for more information

" Plugins {{{
" Start Vim plug and set the plugin directory
call plug#begin(stdpath('config') . '/plugged')
" Common command to install from lock file
let g:from_lock = {'do': 'yarn install --frozen-lockfile'}

" Defaults {{{
Plug 'tpope/vim-sensible'             | " Sensible defaults
Plug 'wincent/terminus'               | " Terminal integration improvements
Plug 'christoomey/vim-tmux-navigator' | " Pane navigation
" }}}

" Search {{{
Plug 'junegunn/fzf'               | " Main FZF plugin
Plug 'junegunn/fzf.vim'           | " Fuzzy finding plugin
Plug 'jesseleite/vim-agriculture' | " Rg options for FZF
" }}}

" Navigation {{{
Plug 'justinmk/vim-dirvish'           | " Replacement for netrw
Plug 'kristijanhusak/vim-dirvish-git' | " Git statuses in dirvish
Plug 'tpope/vim-projectionist'        | " Navigation of related files
Plug 'wincent/vcs-jump'               | " Jump to git things
" }}}

" Visual {{{
Plug 'arecarn/vim-clean-fold'          | " Provides cleaning function for folds
Plug 'blueyed/vim-diminactive'         | " Makes determining active window easier
Plug 'chriskempson/base16-vim'         | " Base16 theme pack
Plug 'edkolev/tmuxline.vim'            | " Makes tmux use airline colors
Plug 'luochen1990/rainbow'             | " Parentheses with matching colors
Plug 'mhinz/vim-signify'               | " Show git info in sidebar
Plug 'mhinz/vim-startify'              | " Startup screen
Plug 'nathanaelkane/vim-indent-guides' | " Provides indentation guides
Plug 'psliwka/vim-smoothie'            | " Nicer scrolling
Plug 'ryanoasis/vim-devicons'          | " Dev icons
Plug 'vim-airline/vim-airline'         | " Airline
Plug 'vim-airline/vim-airline-themes'  | " Status line
Plug 'vim-scripts/folddigest.vim'      | " Visualize folds
Plug 'wincent/loupe'                   | " Search context improvements
Plug 'camspiers/animate.vim'           | " Animation plugin
" }}}

" Editor {{{
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
Plug 'AndrewRadev/splitjoin.vim'          | " Split and join programming lines
Plug 'bkad/CamelCaseMotion'               | " Motions for inside camel case
Plug 'junegunn/vim-easy-align'            | " Helps alignment
Plug 'justinmk/vim-sneak'                 | " Better search motions (s and S, z and Z)
Plug 'kkoomen/vim-doge'                   | " Docblock generator
Plug 'romainl/vim-cool'                   | " Awesome search highlighting
Plug 'tomtom/tcomment_vim'                | " Better commenting
Plug 'tpope/vim-repeat'                   | " Improves repeats handling of Vim plugins
Plug 'tpope/vim-surround'                 | " Surround motions
" }}}

" Formatting {{{
Plug 'editorconfig/editorconfig-vim'      | " Import tabs etc from editorconfig
Plug 'neoclide/coc-prettier', g:from_lock | " Prettier for COC
" }}}

" Tools {{{
Plug 'airblade/vim-rooter'             | " Auto-root setting
Plug 'dstein64/vim-startuptime'        | " Measure startuptime
Plug 'duggiefresh/vim-easydir'         | " Create files in dirs that don't exist
Plug 'inkarkat/vim-ingo-library'       | " Spellcheck dependency
Plug 'inkarkat/vim-spellcheck'         | " Spelling errors to quickfix list
Plug 'junegunn/vim-peekaboo'           | " Peak at registers
Plug 'kassio/neoterm'                  | " REPL integration
Plug 'prashantjois/vim-slack'          | " Slack integration
Plug 'samoshkin/vim-mergetool'         | " Merge tool for git
Plug 'shumphrey/fugitive-gitlab.vim'   | " GitLab support
Plug 'skanehira/docker-compose.vim'    | " Docker compose tools
Plug 'tpope/vim-dadbod'                | " DB tools
Plug 'tpope/vim-eunuch'                | " UNIX tools
Plug 'tpope/vim-fugitive'              | " Git tools
Plug 'tpope/vim-unimpaired'            | " Common mappings for many needs
Plug 'vim-vdebug/vdebug', { 'on': [] } | " Debugging, loaded manually
Plug 'antoyo/vim-licenses'             | " Generate Licences
Plug 'iamcco/markdown-preview.nvim',  { 'do': 'cd app & yarn install'  } | " Markdown preview
" }}}

" Syntax {{{
Plug 'bfontaine/Brewfile.vim'      | " Brewfile
Plug 'ekalinin/dockerfile.vim'     | " Dockerfile
Plug 'jwalton512/vim-blade'        | " blade templates
Plug 'leafgarland/typescript-vim'  | " typescript
Plug 'lilyball/vim-swift'          | " swift
Plug 'peitalin/vim-jsx-typescript' | " typescript jsx, .tsx
Plug 'phalkunz/vim-ss'             | " SilverStripe templates
Plug 'StanAngeloff/php.vim'        | " PHP
Plug 'tmux-plugins/vim-tmux'       | " Tmux conf
" }}}
call plug#end()
" }}}

" Settings {{{

" General {{{
set encoding=UTF-8                    | " Default file encoding
set undofile                          | " Enable undo persistence across sessions
set splitbelow splitright             | " Split defaults
set noautochdir                       | " Don't change dirs automatically
set clipboard=unnamed                 | " System clipboard
set wildignore+=.git/,.DS_Store       | " Ignore patterns
set noerrorbells                      | " No sound
set dictionary=/usr/share/dict/words  | " Set up a dictionary
set hidden                            | " Make buffers hidden then abandoned
" }}}

" Search {{{
set ignorecase       | " Ignores case in search
set smartcase        | " Overrides ignore when capital exists
set inccommand=split | " Displays incremental replacement
" }}}

" Editor {{{
set tabstop=2      | " Number of spaces a <Tab> is
set shiftwidth=2   | " Number of spaces for indentation
set expandtab      | " Expand tab to spaces
set spelllang=en   | " Spell checking
set timeoutlen=750 | " Wait less time for mapped sequences
" }}}

" Visual {{{
set foldtext=clean_fold#fold_text_minimal() | " Clean folds
let &colorcolumn=join(range(121,999),",")   | " Add bulk color past 120
set lazyredraw                              | " Don't redraw while performing a macro
set novisualbell                            | " Don't display visual bell
set showmatch                               | " Show matching braces
set cursorline                              | " Enable current line indicator
set number relativenumber                   | " Show line numbers
let base16colorspace=256                    | " Access colors present in 256 colorspace
colorscheme base16-chalk                    | " Sets theme to chalk
let g:airline_theme='base16_chalk'          | " Sets airline theme to chalk
set termguicolors                           | " Enables 24bit colors
highlight Comment gui=italic                | " Make comments italic
set noshowmode                              | " Don't show mode changes

" }}}

" }}}

" Mappings {{{

" General {{{
" Save file
nnoremap <silent> <Leader>w :write<CR>
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
" Open ripgrep
nnoremap <silent> <Leader>f :Rg<CR>
" Open global grep
nnoremap <silent> <Leader>g :Rgg<CR>
" Open ripgrep for cursor word
nnoremap <silent> <Leader>c :Rg <C-R><C-W><CR>
" Open ripgrep agriculture
nmap <Leader>/ <Plug>RgRawSearch
" Open ripgrep agriculture for visual selection
vmap <Leader>/ <Plug>RgRawVisualSelection
" Open ripgrep agriculture for cursor word
nmap <Leader>* <Plug>RgRawWordUnderCursor
" }}}

" Switching {{{
" Next buffer
nnoremap <silent> <Tab> :bnext<CR>
" Previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>
" Alternate file navigation
nnoremap <silent> <Leader>a :A<CR>
" Alternate file navigation vertical split
nnoremap <silent> <Leader>v :AV<CR>
" }}}

" View Management {{{
" Create vsplit
nnoremap <silent> <Leader>\| :call Vsplit()<CR>
" Create hsplit
nnoremap <silent> <Leader>-  :call Split()<CR>
" Only window
nnoremap <silent> <Leader>o  :only<CR>
" Close the current buffer
nnoremap <silent> <Leader>x    :close<CR>
" Delete the current buffer
nnoremap <silent> <Leader><BS> :bdelete!<CR>
" Close all buffers
nnoremap <silent> <Leader>z    :%bdelete<CR>
" Remap arrows to resize
nnoremap <silent> <Up>    :call animate#window_delta_height(15)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-15)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(30)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-30)<CR>
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
" Git commit messages
nmap <silent> gm <Plug>(git-messenger)
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
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open project
nnoremap <silent> <Leader>] :call OpenVTerm('tmuxinator-fzf-start.sh', 0.2)<CR>
" Switch session
nnoremap <silent> <Leader>[ :call OpenVTerm('tmux-fzf-switch.sh', 0.2)<CR>
" Kill session
nnoremap <silent> <Leader>} :call OpenVTerm('tmux-fzf-kill.sh', 0.2)<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call OpenHTerm('lazygit', 0.8)<CR>
" Open lazydocker
nnoremap <silent> <Leader>; :call OpenHTerm('lazydocker', 0.8)<CR>
" Open harvest
nnoremap <silent> <Leader>h :call OpenHTerm('hstarti', 0.1)<CR>
" Open calendar + todo
nnoremap <silent> <Leader>t :call OpenHTerm('calcurse', 0.8)<CR>
" Toggle pomodoro
nnoremap <silent> <Leader>p :call TogglePomodoro()<CR>
" Register Vdebug only need to call this when you need to change the roots
nnoremap <silent> <Leader>~ :call RegisterVdebug()<CR>
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

let fzf_bindings = [
  \ 'ctrl-a:select-all',
  \ 'ctrl-d:deselect-all',
  \ 'tab:toggle+up',
  \ 'shift-tab:toggle+down'
\ ]

let fzf_opts = [
  \ '--layout=default',
  \ '--info inline',
  \ '--bind ' . join(fzf_bindings, ',')
\ ]
" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = join(fzf_opts, ' ')
" Default location for FZF
" let g:fzf_layout = { 'window': 'new | wincmd J | resize 1' }
let g:fzf_layout = {
 \ 'window': 'new | wincmd J | resize 1 | call animate#window_percent_height(0.5)'
\ }
" Ctrl-l populates arglist. Use with :cfdo. Only works in :Files
let g:fzf_action = {
  \ 'ctrl-l': {l -> execute('args ' . join(map(l, {_, v -> fnameescape(v)}), ' '))},
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" }}}

" Plugin Configuration {{{

" Conquer of Completion {{{
" See coc-settings.json for more configuration
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

function! s:CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
" }}}

" Neoterm {{{

" Sets default location that neoterm opens
let g:neoterm_default_mod = 'botright'
let g:neoterm_autojump = 1
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
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'fzf', 'openterm', 'neoterm']
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

" Fold Digest {{{
let folddigest_options = "nofoldclose,vertical,flexnumwidth"
let folddigest_size = 40
" }}}

" Rainbow Parenthesis {{{
let g:rainbow_active = 1
" }}}

" Licences {{{
let g:licenses_copyright_holders_name = 'Spiers, Cam <camspiers@gmail.com>'
let g:licenses_authors_name = 'Spiers, Cam <camspiers@gmail.com>'
let g:licenses_default_commands = ['mit']
" }}}
" Animate {{{
let g:animate#easing_func = 'animate#ease_out_quad'
" }}}
" }}}

" Custom Tools {{{
" PlugInstall and deletes plugins as needed
function! ReloadPlugins() abort
  let required = map(values(g:plugs), {_, plug -> plug.dir})
  if len(filter(copy(required), {_, dir -> !isdirectory(dir)}))
    PlugInstall
  endif
  let delete = filter(split(glob(g:plug_home.'/*/'), '\n'), {_, dir -> index(required, dir) == -1})
  if len(delete)
    call map(copy(delete), {_, dir -> delete(dir, 'rf')})
    echo 'Deleted plugins: ' . join(map(delete, {_, dir-> fnamemodify(dir[:-2], ':t')}), ', ')
  endif
endfunction
" For empty files it attempts to read a template. Not using au BufNewFile as the
" filetype is being manually set by :New instead of via *.php
function! NewTemplate() abort
  if line('$') == 1 && col('$') == 1
    silent! execute ":0r ~/.config/nvim/templates/".&ft
    :$
  endif
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
" Opens FoldDigest with some default visual settings
function! CustomFoldDigest() abort
  call FoldDigest()
  setlocal listchars= nonumber norelativenumber
endfunction
" Handles closing in cases where you would be the last window
function! CloseWindowOnSuccess(code) abort
  if a:code == 0
    bdelete!
  endif
endfunction
" Open autoclosing terminal, with optional size and dir
function! OpenTerm(cmd) abort
  setf openterm
  call termopen(a:cmd, {'on_exit': {_,c -> CloseWindowOnSuccess(c)}})
endfunction
" Open split with animation
function! OpenHTerm(cmd, percent) abort
  new | wincmd J | resize 1
  call OpenTerm(a:cmd)
  call animate#window_percent_height(a:percent)
endfunction
" Open vsplit with animation
function! OpenVTerm(cmd, percent) abort
  vnew | wincmd L | vertical resize 1
  call OpenTerm(a:cmd)
  call animate#window_percent_width(a:percent)
endfunction
" Creates a vsplit in an animated fashion
function! Vsplit() abort
  vsplit
  let wrap=&wrap
  let width = winwidth(0)
  set nowrap
  vertical resize 1
  call animate#window_absolute_width(width)
  if wrap
    call timer_start(float2nr(g:animate#duration), {t->execute('set wrap')})
  endif
endfunction
" Creates a split with animation
function! Split() abort
  split
  let height = winheight(0)
  resize 1
  call animate#window_absolute_height(height)
endfunction
" }}}

" Commands {{{
" Create new buffers of a particular filetype
command! -nargs=1 -complete=filetype New :new +setf\ <args>
 \ <bar> wincmd J
 \ <bar> let height=winheight(0)
 \ <bar> resize 1
 \ <bar> call animate#window_absolute_height(height)

command! -nargs=1 -complete=filetype Vnew :vnew +setf\ <args>
 \ <bar> wincmd L
 \ <bar> let width=winwidth(0)
 \ <bar> vertical resize 1
 \ <bar> call animate#window_absolute_width(width)

" Opens FZF + Ripgrep for not ignored files
command! -bang -nargs=*                       Rg      call Rg(v:true, <q-args>, <bang>0)
" Opens FZF + Ripgrep for all files
command! -bang -nargs=*                       Rgg     call Rg(v:false, <q-args>, <bang>0)
" Opens a file searcher
command! -bang -nargs=? -complete=dir         Files   call Files(<q-args>, <bang>0)
" Opens search of lines in open buffers
command! -bang -nargs=*                       Lines   call Lines(<q-args>, <bang>0)
" Opens buffer search
command! -bar -bang -nargs=? -complete=buffer Buffers call Buffers(<q-args>, <bang>0)
" Sets up command for prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}

" Auto Commands {{{
" Uncategorized autocmds
augroup General
  autocmd!
  " Put the quickfix window always at the bottom
  autocmd! FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
  " Enable spelling
  autocmd! FileType markdown,txt setlocal spell
  " sources init.vim on save
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh | call ReloadPlugins()
  " New works particularly well with neoterm
  autocmd! FileType * call NewTemplate()
  autocmd! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
" Quit term buffer with ESC
augroup TermHandling
  autocmd!
  " Turn off line numbers, listchars, auto enter insert mode and map esc to
  " exit insert mode
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
    \ | startinsert
    \ | set laststatus=0 noshowmode noruler
    \ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  autocmd! FileType fzf,openterm tnoremap <Esc> <c-c>
  autocmd! FileType neoterm wincmd J
   \ | let height = winheight(0)
   \ | resize 1
   \ | call animate#window_absolute_height(height)
augroup END
" }}}

" vim:fdm=marker
