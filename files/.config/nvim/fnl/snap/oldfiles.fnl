(module snap.oldfiles {autoload {snap snap
                                 nvim aniseed.nvim
                                 core aniseed.core}})

(fn on_select [file winnr]
  (let [buffer (nvim.fn.bufnr file true)]
    (nvim.buf_set_option buffer :buflisted true)
    (when (not= winnr false)
      (nvim.win_set_buf winnr buffer))))

(fn get-slow-data []
  (core.filter #(= (vim.fn.empty (vim.fn.glob $1)) 0) vim.v.oldfiles))

(fn get-results []
  (local (_ results) (coroutine.yield get-slow-data))
  results)

(defn run [] (snap.run {:prompt "Old files"
                          :get-results (snap.filter_with_score get-results)
                          : on_select}))

