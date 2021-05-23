(module snap.action {autoload {snap snap core aniseed.core}})

(local actions {})

(defn add [name action] (tset actions name action))

(fn get_results []
  (core.keys actions))

(fn on_select [action]
  (vim.schedule (. actions action)))

(defn run [] (snap.run {:layout snap.layouts.centered
                        :prompt "Run Action"
                        : get_results
                        :filter true
                        : on_select}))

