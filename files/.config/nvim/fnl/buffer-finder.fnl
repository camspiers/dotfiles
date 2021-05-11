(module buffer-finder {autoload {finder finder nvim aniseed.nvim}})

(defn- on-select [selection winnr]
       (let [buffer (nvim.fn.bufnr selection true)]
         (nvim.buf_set_option buffer :buflisted true)
         (nvim.win_set_buf winnr buffer)))

(defn- get-results [] (icollect [_ value (ipairs (nvim.list_bufs))]
                        (let [name (nvim.buf_get_name value)]
                          (when (not= name "")
                            (when (= (vim.fn.buflisted value) 1)
                              (when (= (vim.fn.bufexists value) 1)
                                name))))))

(defn find [] (finder.run {:prompt "Find Buffers" : get-results : on-select}))

