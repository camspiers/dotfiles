(module snap.tmux {autoload {snap snap utils snap.utils}})

(defn get-results [] (utils.run "tmux list-sessions -F '#S'"))

(fn on-select [project]
  (utils.run (string.format "tmux switch-client -t '%s'" project)))

(defn run [] (snap.run {:layout snap.layouts.centered
                          :prompt "Select Session"
                          : get-results
                          : on-select}))

