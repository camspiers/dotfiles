(module finder {autoload {nvim aniseed.nvim core aniseed.core}
                require {fzy fzy}})

;; Stores mappings for buffers
(def- buffer-fns {})
;; Public but not designed to called by aything but mappings
(defn _execute [bufnr index] ((. (. buffer-fns bufnr) index)))
;; Cleans up unneeded buffer maps
(defn- clean-buffer-fns [bufnr] (tset buffer-fns bufnr nil))
;; Generates the buffer map vim call signiture
(defn- get-vim-call [bufnr fnc]
       (let [fns (or (. buffer-fns bufnr) [])]
         (tset buffer-fns bufnr fns)
         (table.insert fns fnc)
         (string.format "<Cmd>lua require('finder')._execute(%s, %s)<CR>" bufnr
                        (length fns))))

;; Creates window options for different types
(defn- results-window-options [type]
       (match type
         :centered (let [columns (nvim.get_option :columns)
                         lines (nvim.get_option :lines)
                         width (math.floor (* columns 0.9))
                         height (math.floor (/ lines 2))
                         row (math.floor (/ (- lines height) 2))
                         col (math.floor (/ (- columns width) 2))]
                     {: width : height : row : col})
         :bottom (let [columns (nvim.get_option :columns)
                       lines (nvim.get_option :lines)
                       width (math.floor (* columns 0.8))
                       height (math.floor (* lines 0.3))
                       row (- lines height 8)
                       col (math.floor (/ (- columns width) 2))]
                   {: width : height : row : col})))

;; Modifies the basic centerded window options to make the input sit below

;; fnlfmt: skip
(defn- input-window-options [type]
  (let [{: width : height : row : col} (results-window-options type)]
    {: width :height 1 :row (+ height row 2) : col}))

;; Creates a scratch buffer, used for both results and input
(defn- create-buffer [] (nvim.create_buf false true))

;; Creates a window with specified options

;; fnlfmt: skip
(defn- create-window [bufnr {: width : height : row : col}]
  (nvim.open_win bufnr 0 {: width
                          : height
                          : row
                          : col
                          :relative :editor
                          :anchor :NW
                          :style :minimal
                          :border :double}))

;; Creates the results buffer and window
(defn- create-results-view [type]
       (let [bufnr (create-buffer)
             winnr (create-window bufnr (results-window-options type))]
         (nvim.win_set_option winnr :cursorline true)
         {: bufnr : winnr}))

;; Creates the input buffer

;; fnlfmt: skip
(defn- create-input-view [config]
  (let [bufnr (create-buffer)]
    (create-window bufnr (input-window-options config.type))
    (nvim.buf_set_option bufnr :buftype :prompt)
    (vim.fn.prompt_setprompt bufnr config.prompt)
    (nvim.command :startinsert)

    (fn get-filter []
      (let [contents (core.first (nvim.buf_get_lines bufnr 0 1 false))]
        (contents:sub (+ (length config.prompt) 1))))

    (fn on-exit []
      (clean-buffer-fns bufnr)
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

    (fn on-ctrla [] (config.on-selectall (get-filter)))

    (fn on_lines [_ _ _ first last]
        (config.on-update (get-filter)))

    (fn on_detach [] 
      (clean-buffer-fns bufnr))

    (fn map [lhs fnc]
      (let [rhs (get-vim-call bufnr fnc)]
        (nvim.buf_set_keymap bufnr :n lhs rhs {})
        (nvim.buf_set_keymap bufnr :i lhs rhs {})))

    (map :<CR> on-enter)
    (map :<Up> config.on-up)
    (map :<Down> config.on-down)
    (map :<Esc> on-exit)
    (map :<Tab> on-tab)
    (map :<S-Tab> on-shifttab)
    (map :<C-a> on-ctrla)

    (nvim.buf_attach bufnr false {: on_lines : on_detach})

    bufnr))

;; config - {
;;   :prompt string
;;   :get-results () => itable<string> 
;;   :on-select () => nil
;;   :?on-multiselect () => nil
;;   :type "centered" | "bottom"
;;   :filter boolean
;; }

;; fnlfmt: skip
(defn run [config]
  (local type (or config.type "bottom"))
  (local filter (if (= config.filter nil) true config.filter))

  ;; Creates a namespace for highlighting
  (local namespace (nvim.create_namespace "custom_finder"))

  ;; Stores the original window to so we can pass it back to the on-select function
  (local original-winnr (nvim.get_current_win))

  ;; Configures a default or custom prompt
  (local prompt (string.format "%s> " (or config.prompt :Fuzzy)))

  ;; Stores the selected items, used for multiselect
  (local selected {})

  ;; Creates the results buffer and window and stores thier numbers
  (local results-view-info (create-results-view type))

  ;; Helper function for highlighting
  (fn add-results-highlight [row]
    (nvim.buf_add_highlight results-view-info.bufnr namespace "Comment" (- row 1) 0 -1))

  ;; Creates a helper function for writing to the results buffer with highlighting
  (fn write-results [contents]
    (nvim.buf_set_lines results-view-info.bufnr 0 -1 false contents)
    (each [row line (pairs contents)]
      (when (. selected line) (add-results-highlight row))))

  ;; When filter is true (or nil) we always just filter the initial results
  ;; when filter is false, we repeatedly call config.get-results with the new filter
  (local initial-results (config.get-results ""))

  ;; Writes the results to the buffer
  (write-results initial-results)

  ;; Helper function for getting the cursor position
  (fn get-cursor [] (nvim.win_get_cursor results-view-info.winnr))

  ;; Helper function for getting the line under the cursor
  (fn get-cursor-line [row]
    (core.first (nvim.buf_get_lines results-view-info.bufnr (- row 1) row false)))

  ;; Common function to get results wwith filter applied only when needed
  (fn get-results [search]
    (if filter 
      (do
        (local results-table
          (icollect [_ value (ipairs initial-results)]
            (when (fzy.has_match search value)
              {: value :score (fzy.score search value)})))
        (table.sort results-table #(> $1.score $2.score))
        (core.map #(. $1 :value) results-table))
      (config.get-results search)))

  ;; Update function, called when the filter changes
  (fn on-update [search]
    (local results (get-results search))
    (vim.schedule (fn [] (write-results results))))

  ;; Handles exiting
  (fn on-exit [bufnr]
    (nvim.buf_delete bufnr {:force true})
    (nvim.buf_delete results-view-info.bufnr {:force true})
    (nvim.set_current_win original-winnr)
    (nvim.command :stopinsert))

  ;; Handles entering
  (fn on-enter []
    (local selected-values (core.vals selected))
    (if (= (core.count selected-values) 0)
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (config.on-select line original-winnr)))
      (when config.on-multiselect (config.on-multiselect selected-values original-winnr))))

  ;; Handles select all in the multiselect case
  (fn on-selectall [search]
    (when config.on-multiselect
      (each [_ value (ipairs (get-results search))]
        (tset selected value value))
      (for [i 1 (nvim.buf_line_count results-view-info.bufnr)]
        (add-results-highlight i))))

  ;; Handles select in the multiselect case
  (fn on-select []
    (when config.on-multiselect
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (tset selected line line)
          (add-results-highlight row)))))

  ;; Handles unselect in the multiselect case
  (fn on-unselect []
    (when config.on-multiselect
      (let [[row _] (get-cursor) line (get-cursor-line row)]
        (when (not= line "")
          (tset selected line nil)
          (nvim.buf_clear_namespace results-view-info.bufnr namespace (- row 1) row)))))

  ;; On key helper
  (fn on-key [cond get-row]
    (let [[row _] (get-cursor)]
      (when (cond row)
        (nvim.win_set_cursor results-view-info.winnr [(get-row row) 0])
        (nvim.command "redraw!"))))

  ;; On up handler
  (fn on-up []
    (on-key #(> $1 1) #(- $1 1)))

  ;; On down handler
  (fn on-down []
    (on-key #(< $1 (nvim.buf_line_count results-view-info.bufnr)) #(+ $1 1)))

  ;; Initializes the input view
  (create-input-view
    {: type
     : prompt
     : on-update
     : on-enter
     : on-exit
     : on-up
     : on-down
     : on-select
     : on-unselect
     : on-selectall}
    ))

