(module snap.grep {autoload {snap snap
                             io snap.io
                             nvim aniseed.nvim
                             core aniseed.core}})

(fn get_results [message]
  (local cwd (snap.yield vim.fn.getcwd))
  (each [data err kill (io.spawn :rg [:--vimgrep :--hidden message.filter] cwd)]
    (if message.cancel (do
                         (kill)
                         (coroutine.yield nil))
        (not= err "") (coroutine.yield nil)
        (= data "") (coroutine.yield [])
        (coroutine.yield (vim.split data "\n" true)))))

(fn parse [line]
  (let [parts (vim.split line ":")]
    {:filename (. parts 1)
     :lnum (tonumber (. parts 2))
     :col (tonumber (. parts 3))
     :text (. parts 4)}))

(fn on_multiselect [lines winnr]
  (vim.fn.setqflist (core.map parse lines))
  (nvim.command :copen)
  (nvim.command :cfirst))

(fn on_select [line winnr]
  (let [{: filename : lnum : col} (parse line)]
    (print (vim.inspect [lnum col]))
    (let [buffer (nvim.fn.bufnr filename true)]
      (nvim.buf_set_option buffer :buflisted true)
      (nvim.win_set_buf winnr buffer)
      (nvim.win_set_cursor winnr [lnum col]))))

(defn run [] (snap.run {:prompt :Grep
                        : get_results
                        : on_select
                        : on_multiselect}))

(defn cursor [] (snap.run {:prompt :Grep
                           :initial-filter (vim.fn.expand :<cword>)
                           : get_results
                           : on_select
                           : on_multiselect}))

