(module finder.tmuxinator
        {autoload {finder finder
                   utils finder.utils
                   tmux finder.tmux
                   core aniseed.core}})

(fn get-sessions-set []
  (local sessions-set {})
  (each [_ session (ipairs (tmux.get-results))]
    (tset sessions-set session session))
  sessions-set)

(fn get-results []
  (let [sessions (get-sessions-set)]
    (core.filter #(= (. sessions $1) nil)
                 (utils.run "tmuxinator list -n | tail -n +2"))))

(fn launch-session [project]
  (utils.run (string.format "tmuxinator start '%s' --no-attach" project)))

(fn on-select [project]
  (launch-session project)
  (when (vim.fn.exists :$TMUX)
    (vim.schedule tmux.run)))

(fn on-multiselect [projects]
  (each [_ project (ipairs projects)]
    (launch-session project))
  (when (vim.fn.exists :$TMUX)
    (vim.schedule select-session)))

(defn run [] (finder.run {:layout finder.layouts.centered
                          :prompt "Start Session"
                          : get-results
                          : on-select
                          : on-multiselect}))

