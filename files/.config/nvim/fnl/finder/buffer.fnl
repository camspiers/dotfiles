(module finder.buffer {autoload {finder finder
                                 nvim aniseed.nvim
                                 core aniseed.core}})

(fn on-select [selection winnr]
  (let [buffer (nvim.fn.bufnr selection true)]
    (nvim.buf_set_option buffer :buflisted true)
    (nvim.win_set_buf winnr buffer)))

(fn get-slow-data []
  (core.map #(nvim.fn.bufname $1)
            (core.filter #(and (not= (nvim.fn.bufname $1) "")
                               (= (vim.fn.buflisted $1) 1)
                               (= (vim.fn.bufexists $1) 1))
                         (nvim.list_bufs))))

(fn get-results [message]
  message.slow-data)

(defn run [] (finder.run {:prompt :Buffers
                          :get-results (finder.filter-sort get-results)
                          : get-slow-data
                          :filter true
                          : on-select}))

