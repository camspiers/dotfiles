(module finder.cd {autoload {finder finder
                             utils finder.utils
                             config finder.config
                             nvim aniseed.nvim}})

(fn get-results []
  [".."
   (unpack (utils.run "fd --hidden --type d --exclude node_modules --exclude '.git'"))])

(fn on-select [dir winnr]
  (vim.schedule (fn []
                  (nvim.set_current_dir dir))))

(defn run [] (finder.run {:prompt :cd : get-results :filter true : on-select}))

