(module finder {autoload {nvim aniseed.nvim core aniseed.core fzy fzy}})

(local backspace (vim.api.nvim_eval "\"\\<bs>\""))

;; fnlfmt: skip
(defn- create-results-buffer []
  (let [bufnr (nvim.create_buf false true)
        columns (nvim.get_option :columns)
        lines (nvim.get_option :lines)
        width (math.floor (/ columns 2))
        height (math.floor (/ lines 2))
        row (math.floor (/ (- lines height) 2))
        col (math.floor (/ (- columns width) 2))]
    (let [winnr (nvim.open_win bufnr 0
                               {:relative :editor
                                : width : height
                                : row : col
                                :anchor :NW
                                :style :minimal
                                :border :single})]
      (nvim.win_set_option winnr :cursorline true))
    bufnr))

(fn write-results-buffer [bufnr results]
  (nvim.buf_set_lines bufnr 0 -1 true results))

;; fnlfmt: skip
(defn run [config]
  (local prompt (or config.prompt "Fuzzy"))
  (local create-results-buffer (or config.create-results-buffer create-results-buffer))
  (var filter "")
  (var getinput true)
  (local original-win (nvim.get_current_win))
  (local results-bufnr (create-results-buffer))
  (local results (config.get-results))
  (local write-results (partial write-results-buffer results-bufnr))
  (write-results results)
  (while getinput
    (nvim.command :redraw)
    (nvim.command (string.format "echo '%s> %s'" prompt filter))
    (let [char (vim.fn.getchar)]
      (local initial-filter filter)

      (if (= char 27) (set getinput false)
        (= char 13) (do
          (let [selection (nvim.get_current_line)]
            (when config.on-enter (config.on-enter selection original-win)))
          (set getinput false))
        (= char 10) (vim.cmd "norm j")
        (= char 11) (vim.cmd "norm k")
        (= (vim.fn.type char) 0)
          (set filter (.. filter (vim.fn.nr2char char)))
        (= char backspace)
          (set filter (filter:sub 1 -2)))

      (when (~= initial-filter filter)
        (local results-table {})
        (each [_ value (ipairs results)]
          (when (fzy.has_match filter value)
            (table.insert results-table {: value :score (fzy.score filter value)})))
        (table.sort results-table #(> $1.score $2.score))
        (write-results (core.map #(. $1 :value) results-table)))))
  (nvim.buf_delete results-bufnr {:force true})
  (nvim.command "echo ''")
  (nvim.command :redraw))

