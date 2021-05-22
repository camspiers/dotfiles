(module snap.file {autoload {snap snap
                             utils snap.utils
                             config snap.config
                             nvim aniseed.nvim}})

(fn get-results [message]
  (utils.run (string.format "rg --files --no-ignore --hidden %s %s 2> /dev/null"
                            (config.gettypes) (config.getiglobs))))

(fn on-select [file winnr]
  (let [buffer (nvim.fn.bufnr file true)]
    (nvim.buf_set_option buffer :buflisted true)
    (when (not= winnr false)
      (nvim.win_set_buf winnr buffer))))

(fn on-multiselect [files winnr]
  (each [index file (ipairs files)]
    (on-select file (if (= (length files) index) winnr false))))

(defn run [] (snap.run {:prompt :Files
                          :get-results (snap.filter-sort get-results)
                          : on-select
                          : on-multiselect}))

