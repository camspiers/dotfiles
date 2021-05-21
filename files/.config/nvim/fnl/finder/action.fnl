(module finder.action {autoload {finder finder core aniseed.core}})

(local actions {})

(defn add [name action] (tset actions name action))

(fn get-results []
  (core.keys actions))

(fn on-select [action]
  (vim.schedule (. actions action)))

(defn run [] (finder.run {:layout finder.layouts.centered
                          :prompt "Run Action"
                          : get-results
                          :filter true
                          : on-select}))

