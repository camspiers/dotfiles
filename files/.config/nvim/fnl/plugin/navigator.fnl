(module plugin.navigator {autoload {navigator Navigator nvim aniseed.nvim}})

(navigator.setup {})

(fn map [lhs rhs]
  (nvim.set_keymap :n lhs rhs {:noremap true :silent true}))

(map :<C-h> "<Cmd>lua require'Navigator'.left()<CR>")
(map :<C-k> "<Cmd>lua require'Navigator'.up()<CR>")
(map :<C-l> "<Cmd>lua require'Navigator'.right()<CR>")
(map :<C-j> "<Cmd>lua require'Navigator'.down()<CR>")

