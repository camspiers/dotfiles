(module snapcustom.tmux {autoload {snap snap utils snap.utils}})

(defn get_results [] (utils.run "tmux list-sessions -F '#S'"))

(fn on_select [project]
  (utils.run (string.format "tmux switch-client -t '%s'" project)))

(defn run [] (snap.run {:layout snap.layouts.centered
                        :prompt "Select Session"
                        : get_results
                        : on_select}))

