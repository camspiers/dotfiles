(module finder {autoload {nvim aniseed.nvim
                          core aniseed.core
                          fzy fzy
                          wk which-key}
                require {fzy fzy}})

(defn results-window-options []
      (let [columns (nvim.get_option :columns)
            lines (nvim.get_option :lines)
            width (math.floor (/ columns 2))
            height (math.floor (/ lines 2))
            row (math.floor (/ (- lines height) 2))
            col (math.floor (/ (- columns width) 2))]
        {: width : height : row : col}))

(defn input-window-options []
      (let [{: width : height : row : col} (results-window-options)]
        {: width :height 1 :row (+ height row 2) : col}))

(defn create-buffer [] (nvim.create_buf false true))

(defn create-window [bufnr {: width : height : row : col}]
      (nvim.open_win bufnr 0 {: width
                              : height
                              : row
                              : col
                              :relative :editor
                              :anchor :NW
                              :style :minimal
                              :border :double}))

(defn- create-results-buffer []
       (let [bufnr (create-buffer)
             winnr (create-window bufnr (results-window-options))]
         (nvim.win_set_option winnr :cursorline true)
         {: bufnr : winnr}))

(defn- create-input-buffer [config]
       (let [bufnr (create-buffer)]
         (create-window bufnr (input-window-options))
         (nvim.buf_set_option bufnr :buftype :prompt)
         (vim.fn.prompt_setprompt bufnr config.prompt)
         (vim.cmd :startinsert)

         (fn on-exit []
           (config.on-exit bufnr))

         (fn on-enter []
           (config.on-enter)
           (on-exit))

         (fn on-tab []
           (config.on-select)
           (config.on-down))

         (fn on-shifttab []
           (config.on-unselect)
           (config.on-up))

         (wk.register {:<Up> [config.on-up :Up]
                       :<Down> [config.on-down :Down]
                       :<Esc> [on-exit :Exit]
                       :<CR> [on-enter :Go]
                       :<Tab> [on-tab :Select]
                       :<S-Tab> [on-shifttab :Unselect]}
                      {:buffer bufnr :mode :i})
         (wk.register {:<Esc> [on-exit :Exit] :<CR> [on-enter :Select]}
                      {:buffer bufnr :mode :n})

         (fn on_lines [_ _ _ first last]
           (let [contents (core.first (nvim.buf_get_lines bufnr 0 1 false))]
             (config.on-update (contents:sub (+ (length config.prompt) 1)))))

         (nvim.buf_attach bufnr false {: on_lines})
         bufnr))

;; Args:
;;   config - {
;;     :prompt string
;;     :get-results () => itable<string> 
;;     :on-select () => nil
;;     :?on-multiselect () => nil
;;   }

;; fnlfmt: skip
(defn run [config]
  (local namespace (nvim.create_namespace "custom_finder"))
  (local original-winnr (nvim.get_current_win))
  (local prompt (string.format "%s> " (or config.prompt :Fuzzy)))
  (local selected {})
  (local results-view-info (create-results-buffer))
  (fn add-results-highlight [row]
    (nvim.buf_add_highlight results-view-info.bufnr namespace "Comment" (- row 1) 0 -1))
  (local results (config.get-results))
  (fn write-results [contents]
    (nvim.buf_set_lines results-view-info.bufnr 0 -1 false contents)
    (each [row line (pairs contents)]
      (when (~= (. selected line) nil) (add-results-highlight row))))
  (write-results results)
  (fn get-cursor [] (nvim.win_get_cursor results-view-info.winnr))
  (fn get-cursor-line [row] (core.first (nvim.buf_get_lines results-view-info.bufnr (- row 1) row false)))
  (fn on-update [filter]
    (vim.schedule (fn []
      (local results-table
        (icollect [_ value (ipairs results)]
          (when (fzy.has_match filter value)
            {: value :score (fzy.score filter value)})))
      (table.sort results-table #(> $1.score $2.score))
      (write-results (core.map #(. $1 :value) results-table)))))
  (fn on-exit [bufnr]
    (nvim.buf_delete bufnr {:force true})
    (nvim.buf_delete results-view-info.bufnr {:force true})
    (nvim.set_current_win original-winnr)
    (nvim.command :stopinsert))
  (fn on-enter []
    (local selected-values (core.vals selected))
    (if (= (core.count selected-values) 0)
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (config.on-select line original-winnr)))
      (when config.on-multiselect (config.on-multiselect selected-values original-winnr))))
  (fn on-select []
    (when config.on-multiselect
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (tset selected line line)
          (add-results-highlight row)
          ))))
  (fn on-unselect []
    (when config.on-multiselect
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (tset selected line nil)
          (nvim.buf_clear_namespace results-view-info.bufnr namespace (- row 1) row)
          ))))
  (fn on-up []
    (let [[row _] (get-cursor)]
      (when (> row 1)
        (nvim.win_set_cursor results-view-info.winnr [(- row 1) 0])
        (vim.cmd "redraw!"))))
  (fn on-down []
    (let [[row _] (get-cursor)]
      (when (< row (nvim.buf_line_count results-view-info.bufnr))
        (nvim.win_set_cursor results-view-info.winnr [(+ row 1) 0])
        (vim.cmd "redraw!"))))
  (create-input-buffer
    {: prompt
     : on-update
     : on-enter
     : on-exit
     : on-up
     : on-down
     : on-select
     : on-unselect}
    ))

