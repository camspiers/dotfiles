(module options {autoload {nvim aniseed.nvim} require-macros [macros]})

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
(se- cursorline)
(se- cursorcolumn)
(se- history 5000)
(se- wildignore ".git,.git/*,.DS_Store")

(nvim.command "augroup Custom")
(nvim.command "autocmd! TermOpen * set nocursorline")
(nvim.command "autocmd! TermOpen * set nocursorcolumn")
(nvim.command "autocmd! Filetype fennel setlocal syntax=")
(nvim.command "augroup END")

(se- grepprg
     "rg --no-heading --vimgrep --hidden --iglob '!.DS_Store' --iglob '!.git'")

(se- grepformat "%f:%l:%c:%m")

; globals
(g maplocalleader ",")
(g LoupeClearHighlightMap 0)
(g camelcasemotion_key ",")
(g netrw_keepdir 0)
(g netrw_banner 1)

; theme
(g tokyonight_style :night)

; plugin config
(g conjure#client#fennel#aniseed#aniseed_module_prefix :aniseed.)

; commands
(vim.cmd "syntax enable")
(vim.cmd "colorscheme tokyonight")

(vim.cmd "au FileType qf setlocal nonumber norelativenumber nocursorline nocursorcolumn colorcolumn=")

