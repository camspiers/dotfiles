(module dotfiles.plugin.telescope
        {autoload {lualine lualine
                   actions telescope.actions
                   telescope telescope}})

;; Default command for vimgrep
(local telescope-vimgrep-arguments [:rg
                                    :--color=never
                                    :--no-heading
                                    :--with-filename
                                    :--line-number
                                    :--column
                                    :--smart-case
                                    :--hidden
                                    :--iglob
                                    :!.DS_Store
                                    :--iglob
                                    :!.git])

;; Set up telescope
(telescope.setup {:defaults {:vimgrep_arguments telescope-vimgrep-arguments
                             :mappings {:i {:<esc> actions.close}}}
                  :extensions {:fzf {:override_generic_sorter false
                                     :override_file_sorter true
                                     :case_mode :smart_case}}})

;; Load the fzf extension
(telescope.load_extension :fzf)

;; Load the tmuxinator extension
(telescope.load_extension :tmuxinator)

