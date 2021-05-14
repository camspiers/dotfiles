(module finder.file {autoload {finder finder
                               config finder.config
                               nvim aniseed.nvim}})

(fn get-results []
  (finder.cmd.run (string.format "rg --files --no-ignore --hidden %s %s 2> /dev/null"
                                 (config.gettypes) (config.getglobs))))

(defn- on-select [file winnr]
       (let [buffer (nvim.fn.bufnr file true)]
         (nvim.buf_set_option buffer :buflisted true)
         (when (not= winnr false)
           (nvim.win_set_buf winnr buffer))))

(defn- on-multiselect [files winnr]
       (each [index file (ipairs files)]
         (on-select file (if (= (length files) index) winnr false))))

(defn run [] (finder.run {:prompt :Files
                          : get-results
                          : on-select
                          : on-multiselect}))

