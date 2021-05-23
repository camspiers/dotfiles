(module snap.file {autoload {snap snap
                             utils snap.utils
                             config snap.config
                             nvim aniseed.nvim}})

(fn get_results [message]
  (utils.run (string.format "rg --files --no-ignore --hidden %s %s 2> /dev/null"
                            (config.gettypes) (config.getiglobs))))

(fn on_select [file winnr]
  (let [buffer (nvim.fn.bufnr file true)]
    (nvim.buf_set_option buffer :buflisted true)
    (when (not= winnr false)
      (nvim.win_set_buf winnr buffer))))

(fn on_multiselect [files winnr]
  (each [index file (ipairs files)]
    (on_select file (if (= (length files) index) winnr false))))

(defn run [] (snap.run {:prompt :Files
                        :get_results (snap.filter_with_score get_results)
                        : on_select
                        : on_multiselect}))

