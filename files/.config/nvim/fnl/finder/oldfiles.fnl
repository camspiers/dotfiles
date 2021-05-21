(module finder.oldfiles {autoload {finder finder
                                   nvim aniseed.nvim
                                   core aniseed.core}})

(fn on-select [file winnr]
  (let [buffer (nvim.fn.bufnr file true)]
    (nvim.buf_set_option buffer :buflisted true)
    (when (not= winnr false)
      (nvim.win_set_buf winnr buffer))))

(fn get-results []
  (core.filter #(= (vim.fn.empty (vim.fn.glob $1)) 0) vim.v.oldfiles))

(defn run [] (finder.run {:prompt "Old files"
                          : get-results
                          :filter true
                          : on-select}))

