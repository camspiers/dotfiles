(module finder.tmux {autoload {finder finder}})

(fn get-results []
  (finder.cmd.run "tmux list-sessions -F '#S'"))

(fn on-select [project]
  (finder.cmd.run (string.format "tmux switch-client -t '%s'" project)))

(defn run [] (finder.run {:layout finder.layouts.centered
                          :prompt "Select Session"
                          : get-results
                          : on-select}))

