(module finder.tmux {autoload {finder finder utils finder.utils}})

(defn get-results [] (utils.run "tmux list-sessions -F '#S'"))

(fn on-select [project]
  (utils.run (string.format "tmux switch-client -t '%s'" project)))

(defn run [] (finder.run {:layout finder.layouts.centered
                          :prompt "Select Session"
                          : get-results
                          : on-select}))

