(module finder.grep {autoload {finder finder
                               utils finder.utils
                               config finder.config
                               nvim aniseed.nvim
                               astring aniseed.string
                               core aniseed.core}})

(fn spawn [cmd args cwd]
  (var stdinbuffer "")
  (var stderrbuffer "")
  (let [stdout (vim.loop.new_pipe false)
        stderr (vim.loop.new_pipe false)
        handle (vim.loop.spawn cmd {: args :stdio [nil stdout stderr] : cwd}
                               (fn [code signal]
                                 (stdout:read_stop)
                                 (stderr:read_stop)
                                 (stdout:close)
                                 (stderr:close)
                                 (handle:close)))]
    (stdout:read_start (fn [err data]
                         (assert (not err))
                         (when data
                           (set stdinbuffer data))))
    (stderr:read_start (fn [err data]
                         (assert (not err))
                         (when data
                           (set stderrbuffer data))))

    (fn kill []
      (handle:kill vim.loop.constants.SIGTERM))

    (fn iterator []
      (if (and handle (handle:is_active))
          (let [stdin stdinbuffer
                stderr stderrbuffer]
            (set stdinbuffer "")
            (set stderrbuffer "")
            (values stdin stderr kill))
          nil))

    iterator))

(fn get-results [message]
  (local (_ cwd) (coroutine.yield vim.fn.getcwd))
  (each [data err kill (spawn :rg
                              [:--vimgrep
                               ; :--block-buffered
                               :--hidden
                               message.filter] cwd)]
    (if (not= err "")
        (coroutine.yield nil)
        (let [results (if (= data "") [] (vim.split data "\n" true))]
          (coroutine.yield results)
          (when message.cancel
            (kill))))))

(fn parse [line]
  (let [parts (astring.split line ":")]
    {:filename (. parts 1)
     :lnum (tonumber (. parts 2))
     :col (tonumber (. parts 3))
     :text (. parts 4)}))

(fn on-multiselect [lines winnr]
  (vim.fn.setqflist (core.map parse lines))
  (nvim.command :copen)
  (nvim.command :cfirst))

(fn on-select [line winnr]
  (let [{: filename : lnum : col} (parse line)]
    (print (vim.inspect [lnum col]))
    (let [buffer (nvim.fn.bufnr filename true)]
      (nvim.buf_set_option buffer :buflisted true)
      (nvim.win_set_buf winnr buffer)
      (nvim.win_set_cursor winnr [lnum col]))))

(defn run [] (finder.run {:prompt :Grep
                          : get-results
                          : on-select
                          : on-multiselect}))

(defn cursor [] (finder.run {:prompt :Grep
                             :initial-filter (vim.fn.expand :<cword>)
                             : get-results
                             : on-select
                             : on-multiselect}))

