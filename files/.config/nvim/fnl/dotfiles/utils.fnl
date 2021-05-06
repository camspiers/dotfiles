(module dotfiles.utils {autoload {nvim aniseed.nvim a aniseed.core}})

(defn buf-map [buffer mode from to opts] "Sets a buffer mapping"
      (nvim.buf_set_keymap buffer mode from to opts))

(defn map [mode from to opts] "Sets a mapping"
      (nvim.set_keymap mode from to opts))

(defn noremap [mode from to opts] "Sets a noremap mapping"
      (nvim.set_keymap mode from to
                       (a.merge {:noremap true :silent true} (or opts {}))))

(defn nnoremap [...] "Sets a normal mode noremap mapping" (noremap :n ...))
(defn inoremap [...] "Sets a insert mode noremap mapping" (noremap :i ...))
(defn vnoremap [...] "Sets a visual mode noremap mapping" (noremap :v ...))

