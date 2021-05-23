(module snap.buffer {autoload {snap snap nvim aniseed.nvim core aniseed.core}})

(fn on_select [selection winnr]
  (let [buffer (nvim.fn.bufnr selection true)]
    (nvim.buf_set_option buffer :buflisted true)
    (nvim.win_set_buf winnr buffer)))

(fn get-slow-data []
  (core.map #(nvim.fn.bufname $1)
            (core.filter #(and (not= (nvim.fn.bufname $1) "")
                               (= (vim.fn.buflisted $1) 1)
                               (= (vim.fn.bufexists $1) 1))
                         (nvim.list_bufs))))

(fn get_results [message]
  (local (_ buffers) (coroutine.yield get-slow-data))
  buffers)

(defn run [] (snap.run {:prompt :Buffers
                        :get_results (snap.filter_with_score get_results)
                        : on_select}))

