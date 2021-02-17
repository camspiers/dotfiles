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
  \ 'neoclide/coc.nvim':            {'do': { -> coc#util#install()} },
  \ 'iamcco/markdown-preview.nvim': {'do': 'cd app && yarn install'  }
\ }

" Register plugin with options
function! Plug(plugin) abort
  let plugin = substitute(a:plugin, "'", '', 'g')
  call plug#(plugin, get(g:vim_plug_opts, plugin, {}))
endfunction
" }}}

" Plugins {{{
call plug#begin(expand('~/.config/nvim/plugged'))

" Custom command for registering plugins, must follow plug#begin
command! -nargs=1 -bar Plug call Plug(<f-args>)

" Defaults {{{
Plug 'tpope/vim-sensible'         | " Sensible defaults
Plug 'wincent/terminus'           | " Mouse support
" }}}

" Search {{{
Plug 'jesseleite/vim-agriculture' | " Ripgrep options for FZF
Plug 'junegunn/fzf'               | " Main FZF plugin
Plug 'junegunn/fzf.vim'           | " Fuzzy finding plugin
" }}}

" Navigation {{{
Plug 'tpope/vim-projectionist' | " Navigation of related files
Plug 'tpope/vim-vinegar'
Plug 'christoomey/vim-tmux-navigator'
" }}}

" Visual {{{
Plug 'arecarn/vim-clean-fold'     | " Provides function for folds
Plug 'morhetz/gruvbox'
Plug 'glepnir/indent-guides.nvim' | " Provides indentation guides
Plug 'wincent/loupe'              | " Search context improvements
Plug 'hoob3rt/lualine.nvim'       | " Status line
" }}}

" Editor {{{
Plug 'bkad/CamelCaseMotion'          | " Motions for inside camel case
Plug 'editorconfig/editorconfig-vim' | " Import tabs etc from editorconfig
Plug 'kkoomen/vim-doge'              | " Docblock generator
Plug 'matze/vim-move'                | " Move lines
Plug 'neoclide/coc.nvim'             | " Completion provider
Plug 'romainl/vim-cool'              | " Awesome search highlighting
Plug 'tomtom/tcomment_vim'           | " Better commenting
Plug 'tpope/vim-repeat'              | " Improves repeat handling
" }}}

" Tools {{{
Plug 'dhruvasagar/vim-table-mode'    | " Better handling for tables in markdown
Plug 'samoshkin/vim-mergetool'       | " Merge tool for git
Plug 'tpope/vim-fugitive'            | " Git tools
Plug 'tpope/vim-obsession'           | " Save sessions automatically
Plug 'tpope/vim-speeddating'         | " Tools for working with dates
Plug 'tpope/vim-unimpaired'          | " Common mappings for many needs
Plug 'iamcco/markdown-preview.nvim'
Plug 'voldikss/vim-translator'
" }}}

" Syntax {{{
Plug 'sheerun/vim-polyglot'            | " Lang pack
" }}}

call plug#end()
" }}}

" Lua settings
lua << EOF
local lualine = require('lualine')
lualine.status()
lualine.theme = 'gruvbox'
lualine.extensions = { 'fzf' }

require('indent_guides').setup({
  exclude_filetypes = {'help', 'fzf', 'openterm', 'calendar'}
})
EOF

let g:translator_source_lang = 'en'
let g:translator_target_lang = 'es'
let g:translator_window_type = 'popup'

" Translate
vmap <silent> <Leader>t <Plug>TranslateWV
vmap <silent> <Leader><S-t> :'<,'>TranslateW!<CR>

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
set background=dark
let base16colorspace=256                    | " Access colors present in 256 colorspace
set termguicolors                           | " Enables 24bit colors
colorscheme gruvbox                        | " Sets theme to gruvbox
let g:airline_theme='gruvbox'
let &colorcolumn="81,121"                   | " Add indicator for 80 and 120
set foldtext=clean_fold#fold_text_minimal() | " Clean folds
set noshowmode                              | " Don't show mode changes
set novisualbell                            | " Don't display visual bell
set nowrap                                  | " Don't wrap lines
set number                                  | " Show line numbers
set relativenumber                          | " Make line numbers relative
set showmatch                               | " Show matching braces
" Highlight Customizations {{{
highlight Comment gui=italic,bold           | " Make comments italic
" }}}
" }}}
" }}}

" Mappings {{{

" General {{{
" Save file
nnoremap <silent> <Leader>w :write<CR>
" Save and close
nnoremap <silent> <Leader><S-w> :x<CR>
" Open custom digest for folds
nnoremap <silent> <Leader>= :call CustomFoldDigest()<CR>
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
" Create vsplit
nnoremap <silent> <leader>\| :vsplit<CR>
" Create hsplit
nnoremap <silent> <Leader>- :split<CR>
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
" Force close all buffers
nnoremap <silent> <Leader>z :%bdelete<CR>
" Close all buffers
nnoremap <silent> <Leader><S-z> :%bdelete!<CR>
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
endif
" Cycle line number modes
nnoremap <silent> <Leader>r :call CycleLineNumbering()<CR>
" Toggle virtualedit
nnoremap <silent> <Leader>v :call ToggleVirtualEdit()<CR>
" Open lazygit
nnoremap <silent> <Leader>' :call openterm#horizontal('lazygit', 0.8)<CR>
" Open scratch pad
nnoremap <silent> <Leader>sc :call openterm#horizontal('bash', 0.2)<CR>
" }}}
" }}}

" Search Configuration {{{
" Use agriculture as a global no hidden search
let g:agriculture#rg_options = '--no-ignore --hidden'
" Some ripgrep searching defaults
function! RgCommand(ignore) abort
  return join([
    \ 'rg', '--hidden', '--color ansi', '--column',
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
endfunction
" Opens files search with preview
function! Files(args, bang) abort
  call fzf#vim#files(a:args, Preview(PreviewFlags('Files')), a:bang)
endfunction
" Opens lines with animation
function! Lines(args, bang) abort
  call fzf#vim#lines(a:args, a:bang)
endfunction
" Opens buffers with animation
function! Buffers(args, bang) abort
  call fzf#vim#buffers(a:args, a:bang)
endfunction
" Default FZF options with bindings to match layout and select all + none
let $FZF_DEFAULT_OPTS = join(
  \ [
    \ '--layout=default', '--info inline',
    \ '--bind ' . join(
      \ [
        \ 'ctrl-a:select-all', 'ctrl-d:deselect-all',
        \ 'tab:toggle+up', 'shift-tab:toggle+down',
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

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

" Plugin Configuration {{{

" Table Mode {{{
let g:table_mode_corner = '|'
" }}}

" Loupe {{{
let g:LoupeClearHighlightMap = 0
" }}}

" Conquer of Completion {{{

" Plugins {{{
" coc-git is causing start screen not to show
" \ 'coc-git',
let g:coc_global_extensions = [
  \ 'coc-css', 'coc-html', 'coc-json', 'coc-snippets',
  \ 'coc-prettier', 'coc-sh', 'coc-stylelint', 'coc-tsserver',
  \ 'coc-vimlsp', 'coc-tailwindcss'
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

" Merge Tool {{{
" 3-way merge
let g:mergetool_layout = 'bmr'
let g:mergetool_prefer_revision = 'local'
" }}}

" Camelcase Motion {{{
" Sets up within word motions to use ,
let g:camelcasemotion_key = ','
" }}}

" Fold Digest {{{
let folddigest_options = "nofoldclose,vertical,flexnumwidth"
let folddigest_size = 40
" }}}

" }}}

" Custom Tools {{{
" Enabled appropriate options for text files
function! EnableTextFileSettings() abort
  setlocal spell
  silent TableModeEnable
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

" Opens FoldDigest with some default visual settings
function! CustomFoldDigest() abort
  call FoldDigest()
  call EnableCleanUI()
  set winfixwidth
endfunction
" Animate the quickfix and ensure it is at the bottom
function! OpenQuickFix() abort
  if getwininfo(win_getid())[0].loclist != 1
    wincmd J
  endif
endfunction
" Configures an FZF window
function! NewFZFWindow() abort
  new | wincmd J
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
" Sets up command for prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" }}}
function! OnFZFOpen() abort
  call EnableCleanUI()
  tnoremap <Esc> <c-c>
  startinsert
endfunction

" Auto Commands {{{
augroup General
  autocmd!
  " Put the quickfix window always at the bottom
  autocmd! FileType qf call OpenQuickFix()
  " Enable text file settings
  autocmd! FileType markdown,txt,tex call EnableTextFileSettings()
  autocmd! FileType fzf call OnFZFOpen()
  if has('nvim')
    autocmd! TermOpen * let g:last_open_term_id = b:terminal_job_id
  endif
augroup END
" }}}

" vim:fdm=marker
