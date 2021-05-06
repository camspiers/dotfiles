(module dotfiles.options {require-macros [dotfiles.macros]})

(se- background :dark)
(se- clipboard :unnamed)
(se- colorcolumn "81,121")
(se- completeopt "menuone,noselect")
(se- expandtab)
(se- hidden)
(se- ignorecase)
(se- inccommand :split)
(se- lazyredraw)
(se- mouse :a)
(se- noautochdir)
(se- noerrorbells)
(se- noshowmode)
(se- noswapfile)
(se- novisualbell)
(se- nowrap)
(se- number)
(se- relativenumber)
(se- shiftwidth 2)
(se- showmatch)
(se- signcolumn :yes)
(se- smartcase)
(se- spelllang :en)
(se- splitbelow)
(se- splitright)
(se- tabstop 2)
(se- termguicolors)
(se- timeoutlen 500)
(se- undofile)
(se- updatetime 300)

; globals
(g mapleader "\\")
(g maplocalleader ",")
(g LoupeClearHighlightMap 0)
(g camelcasemotion_key ",")

; theme
(g tokyonight_style :night)

; plugin config
(g conjure#client#fennel#aniseed#aniseed_module_prefix :aniseed.)

; commands
(vim.cmd "syntax enable")
(vim.cmd "colorscheme tokyonight")

