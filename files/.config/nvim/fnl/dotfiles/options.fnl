(module dotfiles.options)

; window options
(set vim.wo.wrap false)
(set vim.wo.number true)
(set vim.wo.relativenumber true)
(set vim.wo.signcolumn :yes)

; globals
(set vim.g.mapleader "\\")
(set vim.g.maplocalleader ",")
(set vim.g.LoupeClearHighlightMap 0)
(set vim.g.camelcasemotion_key ",")

; options
(set vim.o.mouse :a)
(set vim.o.completeopt "menuone,noselect")
(set vim.o.colorcolumn "81,121")
(set vim.o.background :dark)
(set vim.o.tabstop 2)
(set vim.o.shiftwidth 2)
(set vim.o.inccommand :split)
(set vim.o.visualbell false)
(set vim.o.showmatch true)
(set vim.o.autochdir false)
(set vim.o.errorbells false)
(set vim.o.expandtab true)
(set vim.o.undofile true)
(set vim.o.ignorecase true)
(set vim.o.smartcase true)
(set vim.o.spelllang :en)
(set vim.o.splitbelow true)
(set vim.o.splitright true)
(set vim.o.termguicolors true)
(set vim.o.showmode false)
(set vim.o.hidden true)
(set vim.o.swapfile false)
(set vim.o.updatetime 300)
(set vim.o.timeoutlen 500)
(set vim.o.clipboard :unnamed)

; theme
(set vim.g.tokyonight_style :night)

; plugin config
(set vim.g.conjure#client#fennel#aniseed#aniseed_module_prefix :aniseed.)

; commands
(vim.cmd "syntax enable")
(vim.cmd "colorscheme tokyonight")

(set vim.o.wildignore (.. vim.o.wildignore
                          (table.concat [:*.orig
                                         :*.sw?
                                         :*.DS_Store
                                         :*.git
                                         :*.hg]
                                        ",")))

