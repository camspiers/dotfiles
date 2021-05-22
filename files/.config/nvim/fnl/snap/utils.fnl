(module snap.utils {autoload {core aniseed.core}})

;; Runs a command and waits for output
(defn run [cmd]
      (let [file (io.popen cmd :r)
            contents (file:read :*all)]
        (file:close)
        (core.filter #(not= $1 "") (vim.split contents "\n"))))

