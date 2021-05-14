(module finder.buffer {autoload {finder finder nvim aniseed.nvim}})

(defn- on-select [selection winnr]
       (let [buffer (nvim.fn.bufnr selection true)]
         (nvim.buf_set_option buffer :buflisted true)
         (nvim.win_set_buf winnr buffer)))

(defn- get-results [] (icollect [_ value (ipairs (nvim.list_bufs))]
                        (let [name (nvim.fn.bufname value)]
                          (when (and (not= name "")
                                     (= (vim.fn.buflisted value) 1)
                                     (= (vim.fn.bufexists value) 1))
                            name))))

(defn run [] (finder.run {:prompt :Buffers : get-results : on-select}))

