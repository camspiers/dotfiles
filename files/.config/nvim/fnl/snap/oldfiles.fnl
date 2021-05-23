(module snap.oldfiles {autoload {snap snap}})

(fn on_select [file winnr]
  (let [buffer (vim.fn.bufnr file true)]
    (vim.api.nvim_buf_set_option buffer :buflisted true)
    (when (not= winnr false)
      (vim.api.nvim_win_set_buf winnr buffer))))

(fn get-slow-data []
  (vim.tbl_filter #(= (vim.fn.empty (vim.fn.glob $1)) 0) vim.v.oldfiles))

(fn get_results []
  (local results (snap.yield get-slow-data))
  results)

(defn run [] (snap.run {:prompt "Old files"
                        :get_results (snap.filter_with_score get-results)
                        : on_select}))

