(module dotfiles.options {require-macros [dotfiles.macros]})

; window options
(wopt wrap false)
(wopt number)
(wopt relativenumber)
(wopt signcolumn :yes)
(wopt colorcolumn "81,121")

; buffer options
(bopt spelllang :en)
(bopt undofile)
; need to set both for some reason
(opt undofile)
(bopt iskeyword+ "-")
(bopt swapfile false)
(bopt expandtab)
(bopt tabstop 2)
(bopt shiftwidth 2)

; global options
(opt lazyredraw)
(opt mouse :a)
(opt completeopt "menuone,noselect")
(opt background :dark)
(opt inccommand :split)
(opt visualbell false)
(opt showmatch)
(opt autochdir false)
(opt errorbells false)
(opt ignorecase)
(opt smartcase)
(opt splitbelow)
(opt splitright)
(opt termguicolors)
(opt showmode false)
(opt hidden)
(opt updatetime 300)
(opt timeoutlen 500)
(opt clipboard :unnamed)
(opt wildignore+ (table.concat [:*.orig :*.sw? :*.DS_Store :*.git :*.hg] ","))

; globals
(g :mapleader "\\")
(g :maplocalleader ",")
(g :LoupeClearHighlightMap 0)
(g :camelcasemotion_key ",")

; theme
(g :tokyonight_style :night)

; plugin config
(g "conjure#client#fennel#aniseed#aniseed_module_prefix" :aniseed.)

; commands
(vim.cmd "syntax enable")
(vim.cmd "colorscheme tokyonight")

