(module plugin.compe {autoload {nvim aniseed.nvim compe compe}})

;; Set up compe
(compe.setup {:enable true
              :autocomplete false
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

(fn map [lhs rhs]
  (nvim.set_keymap :i lhs rhs {:noremap true :silent true :expr true}))

(map :<C-Space> "compe#complete()")
(map :<CR> "compe#confirm('<CR>')")
(map :<C-e> "compe#close('<C-e>')")

