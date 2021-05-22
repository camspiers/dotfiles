(module snap.action {autoload {snap snap core aniseed.core}})

(local actions {})

(defn add [name action] (tset actions name action))

(fn get-results []
  (core.keys actions))

(fn on-select [action]
  (vim.schedule (. actions action)))

(defn run [] (snap.run {:layout snap.layouts.centered
                        :prompt "Run Action"
                        : get-results
                        :filter true
                        : on-select}))

