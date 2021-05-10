(module plugin.compe {autoload {compe compe utils utils}})

;; Set up compe
(compe.setup {:enable true
              :autocomplete true
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

(utils.inoremap :<C-Space> "compe#complete()" {:expr true})
(utils.inoremap :<CR> "compe#confirm('<CR>')" {:expr true})
(utils.inoremap :<C-e> "compe#close('<C-e>')" {:expr true})

