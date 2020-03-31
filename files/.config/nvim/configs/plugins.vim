" Install vim-plugged if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let g:plugin_opts = {
  \ 'neoclide/coc.nvim':                { 'do': { -> coc#util#install()} },
  \ 'neoclide/coc-css':                 { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-eslint':              { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-git':                 { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-html':                { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-json':                { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-lists':               { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-pairs':               { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-prettier':            { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-snippets':            { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-tslint':              { 'do': 'yarn install --frozen-lockfile' },
  \ 'neoclide/coc-tsserver':            { 'do': 'yarn install --frozen-lockfile' },
  \ 'glacambre/firenvim': has('nvim') ? { 'do': { _ -> firenvim#install(0) } } : {'on': []},
  \ 'iamcco/markdown-preview.nvim':     { 'do': 'cd app & yarn install'  },
  \ 'vim-vdebug/vdebug':                { 'on': [] },
\ }

" New function to register plugins
function! RegPlugin(plugin)
  let plugin = substitute(a:plugin, "'", '', 'g')
  let plugin_opts = has_key(g:plugin_opts, plugin) ? g:plugin_opts[plugin] : {}
  call plug#(plugin, plugin_opts)
endfunction

" Enable vim plug
call plug#begin(expand('~/.config/nvim/plugged'))

" Override vim-plug Plug, must appear after "plug#begin"
command! -nargs=1 -bar Plug call RegPlugin(<f-args>)

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
Plug 'justinmk/vim-dirvish'           | " Replacement for netrw
Plug 'kristijanhusak/vim-dirvish-git' | " Git statuses in dirvish
Plug 'tpope/vim-projectionist'        | " Navigation of related files
Plug 'wincent/vcs-jump'               | " Jump to git things
Plug 'ap/vim-buftabline'              | " Minimal plugin for displaying buffers
" }}}

" Visual {{{
Plug 'arecarn/vim-clean-fold'          | " Provides function for folds
Plug 'blueyed/vim-diminactive'         | " Helps identifying active window
Plug 'camspiers/animate.vim'           | " Animation plugin
Plug 'camspiers/lens.vim'              | " Window resizing plugin
Plug 'chriskempson/base16-vim'         | " Base16 theme pack
Plug 'mhinz/vim-startify'              | " Startup screen
Plug 'nathanaelkane/vim-indent-guides' | " Provides indentation guides
Plug 'ryanoasis/vim-devicons'          | " Dev icons
Plug 'vim-scripts/folddigest.vim'      | " Visualize folds
Plug 'wincent/loupe'                   | " Search context improvements
" }}}

" Conquer of Completion {{{
Plug 'neoclide/coc.nvim'     | " Completion provider
Plug 'neoclide/coc-css'      | " CSS language server
Plug 'neoclide/coc-eslint'   | " Eslint integration
Plug 'neoclide/coc-git'      | " Git info
Plug 'neoclide/coc-html'     | " Html language server
Plug 'neoclide/coc-json'     | " JSON language server
Plug 'neoclide/coc-lists'    | " Arbitrary lists
Plug 'neoclide/coc-pairs'    | " Auto-insert language aware pairs
Plug 'neoclide/coc-prettier' | " Prettier for COC
Plug 'neoclide/coc-snippets' | " Provides snippets
Plug 'neoclide/coc-tslint'   | " Tslint integration
Plug 'neoclide/coc-tsserver' | " TypeScript language server
" }}}

" Editor {{{
Plug 'bkad/CamelCaseMotion'          | " Motions for inside camel case
Plug 'editorconfig/editorconfig-vim' | " Import tabs etc from editorconfig
Plug 'junegunn/vim-easy-align'       | " Helps alignment
Plug 'kkoomen/vim-doge'              | " Docblock generator
Plug 'lervag/vimtex'                 | " Support for vimtex
Plug 'matze/vim-move'                | " Move lines
Plug 'reedes/vim-pencil'             | " Auto hard breaks for text files
Plug 'romainl/vim-cool'              | " Awesome search highlighting
Plug 'tomtom/tcomment_vim'           | " Better commenting
Plug 'tpope/vim-repeat'              | " Improves repeat handling
Plug 'tpope/vim-surround'            | " Surround motions
Plug 'wellle/targets.vim'            | " Move text objects
Plug 'terryma/vim-multiple-cursors'  | " Multiple cursor support like Sublime
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
" }}}

" Syntax {{{
Plug 'bfontaine/Brewfile.vim'          | " Brewfile
Plug 'phalkunz/vim-ss'                 | " SilverStripe templates
Plug 'reasonml-editor/vim-reason-plus' | " Reason support
Plug 'sheerun/vim-polyglot'            | " Lang pack
" }}}

" End the plugin registration
call plug#end()
