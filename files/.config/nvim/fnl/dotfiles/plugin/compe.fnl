(module dotfiles.plugin.compe {autoload {compe compe}})

;; Set up compe
(compe.setup {:autocomplete true
              :min_length 1
              :preselect :enable
              :documentation true
              :source {:conjure true
                       :path true
                       :buffer true
                       :calc true
                       :vsnip true
                       :nvim_lsp true
                       :nvim_lua true
                       :spell true
                       :treesitter true
                       :tags false}})

