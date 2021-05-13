(module finder.tmuxinator
        {autoload {finder finder astring aniseed.string core aniseed.core}})

;; Run and wait
(fn run [cmd]
  (let [file (io.popen cmd :r)
        contents (file:read :*all)]
    (file:close)
    (core.filter #(not= $1 "") (astring.split contents "\n"))))

(fn get-sessions []
  (run "tmux list-sessions -F '#S'"))

(fn get-sessions-set []
  (local sessions-set {})
  (each [_ session (ipairs (get-sessions))]
    (tset sessions-set session session))
  sessions-set)

(fn get-results []
  (let [sessions (get-sessions-set)]
    (core.filter #(= (. sessions $1) nil)
                 (run "tmuxinator list -n | tail -n +2"))))

(fn launch-session [project]
  (run (string.format "tmuxinator start '%s' --no-attach" project)))

(fn attach-session [project]
  (run (string.format "tmux switch-client -t '%s'" project)))

(fn select-session []
  (finder.run {:type :centered
               :prompt "Select Session"
               :get-results get-sessions
               :on-select attach-session}))

(fn on-select [project]
  (launch-session project)
  (when (vim.fn.exists :$TMUX)
    (vim.schedule select-session)))

(fn on-multiselect [projects]
  (each [_ project (ipairs projects)]
    (launch-session project))
  (when (vim.fn.exists :$TMUX)
    (vim.schedule select-session)))

(defn find [] (finder.run {:type :centered
                           :prompt "Start Session"
                           : get-results
                           : on-select
                           : on-multiselect}))

