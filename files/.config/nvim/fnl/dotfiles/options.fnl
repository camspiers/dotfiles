(module dotfiles.options {autoload {nvim aniseed.nvim}})

; window options
(set nvim.wo.wrap false)
(set nvim.wo.number true)
(set nvim.wo.relativenumber true)
(set nvim.wo.signcolumn :yes)

; globals
(set nvim.g.mapleader "\\")
(set nvim.g.maplocalleader ",")
(set nvim.g.LoupeClearHighlightMap 0)
(set nvim.g.camelcasemotion_key ",")

; options
(set nvim.o.mouse :a)
(set nvim.o.completeopt "menuone,noselect")
(set nvim.o.colorcolumn "81,121")
(set nvim.o.background :dark)
(set nvim.o.tabstop 2)
(set nvim.o.shiftwidth 2)
(set nvim.o.inccommand :split)
(set nvim.o.visualbell false)
(set nvim.o.showmatch true)
(set nvim.o.autochdir false)
(set nvim.o.errorbells false)
(set nvim.o.expandtab true)
(set nvim.o.undofile true)
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.spelllang :en)
(set nvim.o.splitbelow true)
(set nvim.o.splitright true)
(set nvim.o.termguicolors true)
(set nvim.o.showmode false)
(set nvim.o.hidden true)
(set nvim.o.swapfile false)
(set nvim.o.updatetime 300)
(set nvim.o.timeoutlen 500)
(set nvim.o.clipboard :unnamed)

; theme
(set nvim.g.tokyonight_style :night)

; plugin config
(set nvim.g.conjure#client#fennel#aniseed#aniseed_module_prefix :aniseed.)

; commands
(nvim.command "syntax enable")
(nvim.command "colorscheme tokyonight")

(set nvim.o.wildignore (.. nvim.o.wildignore
                           (table.concat [:*.orig
                                          :*.sw?
                                          :*.DS_Store
                                          :*.git
                                          :*.hg]
                                         ",")))

