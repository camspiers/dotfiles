(module snapcustom.tmuxinator
        {autoload {snap snap utils snap.utils tmux snap.tmux core aniseed.core}})

(fn get-sessions-set []
  (local sessions-set {})
  (each [_ session (ipairs (tmux.get_results))]
    (tset sessions-set session session))
  sessions-set)

(fn get_results []
  (let [sessions (get-sessions-set)]
    (core.filter #(= (. sessions $1) nil)
                 (utils.run "tmuxinator list -n | tail -n +2"))))

(fn launch-session [project]
  (utils.run (string.format "tmuxinator start '%s' --no-attach" project)))

(fn on_select [project]
  (launch-session project)
  (when (vim.fn.exists :$TMUX)
    (vim.schedule tmux.run)))

(fn on_multiselect [projects]
  (each [_ project (ipairs projects)]
    (launch-session project))
  (when (vim.fn.exists :$TMUX)
    (vim.schedule select-session)))

(defn run [] (snap.run {:layout snap.layouts.centered
                        :prompt "Start Session"
                        : get_results
                        : on_select
                        : on_multiselect}))

