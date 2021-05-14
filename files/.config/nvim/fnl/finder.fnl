(module finder {autoload {nvim aniseed.nvim
                          core aniseed.core
                          astring aniseed.string}
                require {fzy fzy}})

;; Common cmd utilities, used by external finder users
(def cmd {})

;; Runs a command and waits for output
(fn cmd.run [cmd]
  (let [file (io.popen cmd :r)
        contents (file:read :*all)]
    (file:close)
    (core.filter #(not= $1 "") (astring.split contents "\n"))))

;; Global accessible layouts
;; Currently layouts always have the input placed below and therefore room
;; must be left available for it to fit
(def layouts {})

(fn layouts.centered [columns lines]
  (let [width (math.floor (* columns 0.9))
        height (math.floor (/ lines 2))]
    {: width
     : height
     :row (math.floor (/ (- lines height) 2))
     :col (math.floor (/ (- columns width) 2))}))

(fn layouts.bottom [columns lines]
  (let [width (math.floor (* columns 0.8))
        height (math.floor (* lines 0.3))]
    {: width
     : height
     :row (- lines height 8)
     :col (math.floor (/ (- columns width) 2))}))

;; Stores mappings for buffers
(def fns {})

;; Cleans up unneeded buffer maps
(fn fns.clean [bufnr]
  (tset fns bufnr nil))

;; Provides ability to run fn
(fn fns.run [bufnr fnc]
  (when (and (. fns bufnr) (. fns bufnr fnc))
    ((. fns bufnr fnc))))

(fn fns.get-by-template [bufnr fnc template]
  (let [buf-fns (or (. fns bufnr) [])
        id (string.format "%s" fnc)]
    (tset fns bufnr buf-fns)
    (when (= (. buf-fns id) nil)
      (tset buf-fns id fnc))
    (string.format template bufnr id)))

;; Generates the buffer map vim call signiture
(fn fns.get-call [bufnr fnc]
  (fns.get-by-template bufnr fnc
                       "<Cmd>lua require'finder'.fns.run(%s, '%s')<CR>"))

;; Pattern for autocmds
(fn fns.get-autocmd-call [bufnr fnc]
  (fns.get-by-template bufnr fnc ":lua require'finder'.fns.run(%s, '%s')"))

;; Creates a buffer mapping and creates callable signiture
(fn map [bufnr lhs fnc]
  (let [rhs (fns.get-call bufnr fnc)]
    (nvim.buf_set_keymap bufnr :n lhs rhs {})
    (nvim.buf_set_keymap bufnr :i lhs rhs {})))

;; Creates window options for different layouts
(defn- create-layout [layout]
       (layout (nvim.get_option :columns) (nvim.get_option :lines)))

;; Modifies the basic window options to make the input sit below

;; fnlfmt: skip
(defn- create-input-layout [layout]
  (let [{: width : height : row : col} (create-layout layout)]
    {: width :height 1 :row (+ height row 2) : col}))

;; Creates a scratch buffer, used for both results and input
(defn- create-buffer [] (nvim.create_buf false true))

;; Creates a window with specified options

;; fnlfmt: skip
(defn- create-window [bufnr {: width : height : row : col} focusable]
  (nvim.open_win bufnr 0 {: width
                          : height
                          : row
                          : col
                          : focusable
                          :relative :editor
                          :anchor :NW
                          :style :minimal
                          :border ["╭" "─" "╮" "│" "╯" "─" "╰" "│"]}))

;; Creates the results buffer and window

;; fnlfmt: skip
(defn- create-results-view [config]
  (let [bufnr (create-buffer)
        winnr (create-window bufnr (create-layout config.layout) false)]
    (nvim.win_set_option winnr :cursorline true)
    (nvim.buf_set_option bufnr :buftype :prompt)
    {: bufnr : winnr}))

;; Creates the input buffer

;; fnlfmt: skip
(defn- create-input-view [config]
  (let [bufnr (create-buffer)
        winnr (create-window bufnr (create-input-layout config.layout) true)]
    (nvim.buf_set_option bufnr :buftype :prompt)
    (vim.fn.prompt_setprompt bufnr config.prompt)
    (nvim.command :startinsert)

    (fn get-filter []
      (let [contents (core.first (nvim.buf_get_lines bufnr 0 1 false))]
        (contents:sub (+ (length config.prompt) 1))))

    (fn on-exit []
      (fns.clean bufnr)
      (config.on-exit))

    (fn on-enter []
      (config.on-enter)
      (on-exit))

    (fn on-tab []
      (config.on-select)
      (config.on-down))

    (fn on-shifttab []
      (config.on-unselect)
      (config.on-up))

    (fn on-ctrla []
      (config.on-selectall (get-filter)))

    (var mounted false)
    (fn on_lines []
      (if mounted
        (config.on-update (get-filter))
        (set mounted true)))

    (fn on_detach [] 
      (fns.clean bufnr))

    (map bufnr :<CR> on-enter)
    (map bufnr :<Up> config.on-up)
    (map bufnr :<C-k> config.on-up)
    (map bufnr :<C-p> config.on-down)
    (map bufnr :<Down> config.on-down)
    (map bufnr :<C-j> config.on-down)
    (map bufnr :<C-n> config.on-down)
    (map bufnr :<Esc> on-exit)
    (map bufnr :<C-c> on-exit)
    (map bufnr :<Tab> on-tab)
    (map bufnr :<S-Tab> on-shifttab)
    (map bufnr :<C-a> on-ctrla)

    (nvim.command "augroup Finder")
    (nvim.command (string.format
                    "autocmd! WinLeave <buffer=%s> %s"
                    bufnr
                    (fns.get-autocmd-call bufnr on-exit)))
    (nvim.command "augroup END")

    (nvim.buf_attach bufnr false {: on_lines : on_detach})

    {: bufnr : winnr}))

;; Turn table into chunks
(fn chunks [size tbl]
  (local cs [])
  (var c [])
  (each [index value (ipairs tbl)]
    (table.insert c value)
    (when (or (= (length c) size) (= index (length tbl)))
      (table.insert cs c)
      (set c [])))
  cs)

;; config {
;;   "The prompt displayed to the user"
;;   :prompt string

;;   "Get the results to display"
;;   :get-results () => itable<string>

;;   "What to run on select"
;;   :on-select (selection) => nil

;;   "How to display the searcher"
;;   :layout (columns lines) => {:width number :height number :row number :col number}

;;   "An optional get new results on filter change"
;;   :?on-filter (filter initial-results) => itable<string>

;;   "An optional function that enables multiselect executes on multiselect"
;;   :?on-multiselect (selections) => nil
;; }

;; fnlfmt: skip
(defn run [config]
  ;; Store buffers for exiting
  (local buffers [])

  ;; Default debounce
  (local on-update-debounce 100)

  ;; Default render chunk size
  (local render-chunk-size 200)

  ;; Default to the bottom layout
  (local layout (or config.layout layouts.bottom))

  ;; Computes the initial results
  (local initial-results (config.get-results))

  ;; Creates a namespace for highlighting
  (local namespace (nvim.create_namespace "custom_finder"))

  ;; Stores the original window to so we can pass it back to the on-select function
  (local original-winnr (nvim.get_current_win))

  ;; Configures a default or custom prompt
  (local prompt (string.format "%s> " (or config.prompt :Find)))

  ;; Stores the selected items, used for multiselect
  (local selected {})

  ;; Handles exiting
  (fn on-exit []
    (each [_ bufnr (ipairs buffers)]
      (when (nvim.buf_is_valid bufnr)
        (nvim.buf_delete bufnr {:force true})))
    (nvim.set_current_win original-winnr)
    (nvim.command :stopinsert))

  ;; Creates the results buffer and window and stores thier numbers
  (local results-view-info (create-results-view {: layout : on-exit}))

  ;; Register buffer for exiting
  (table.insert buffers results-view-info.bufnr)

  ;; Helper function for highlighting
  (fn add-results-highlight [row]
    (nvim.buf_add_highlight results-view-info.bufnr namespace :Comment (- row 1) 0 -1))

  ;; Creates a helper function for writing to the results buffer with highlighting
  (fn write-results [results]
    (nvim.buf_set_lines results-view-info.bufnr 0 1 false results)
    (each [row line (pairs results)]
      (when (. selected line) (add-results-highlight row))))

  ;; Incremental writes
  (fn write-results-inc [results]
    (if (= (length results) 0)
      ;; If there are no results then clear
      (nvim.buf_set_lines results-view-info.bufnr 0 -1 false results)
      ;; Otherwise render the chunks
      (do
        (let [result-chunks (chunks render-chunk-size results)]
          (each [index chunk (ipairs result-chunks)]
            (let [size (length chunk)]
              ;; Render the chunks lines
              (nvim.buf_set_lines
                results-view-info.bufnr
                (* (- index 1) size)
                (* index size)
                false
                chunk)
              ;; If we are on the last chunk clear all content past its last entry
              (when (= index (length result-chunks))
                (nvim.buf_set_lines
                  results-view-info.bufnr
                  (* index size)
                  -1
                  false
                  [])))
            (coroutine.yield)))
        (each [row line (pairs results)]
          (when (. selected line) (add-results-highlight row))))))

  ;; Helper function for getting the cursor position
  (fn get-cursor [] (nvim.win_get_cursor results-view-info.winnr))

  ;; Helper function for getting the line under the cursor
  (fn get-cursor-line [row]
    (core.first (nvim.buf_get_lines results-view-info.bufnr (- row 1) row false)))

  ;; Common function to get results with filter applied only when needed
  (fn get-results [search]
    (if config.on-filter
      (config.on-filter search initial-results)
      (do
        ;; This code path resuses initial-results and filters using fzy
        (local results-table
          (icollect [_ value (ipairs initial-results)]
            (when (fzy.has_match search value)
              {: value :score (fzy.score search value)})))
        (table.sort results-table #(> $1.score $2.score))
        (core.map #(. $1 :value) results-table))))

  ;; Debouncing
  (var timer nil)

  ;; Update function, called when the filter changes
  (fn on-update [search]
    ;; Redraw for quick updating of input
    (nvim.command :redraw)

    ;; When a new update comes and there is still a timer then cancel it
    (when timer (vim.loop.timer_stop timer))

    ;; Store a timer for stopping. This is a debounce strategy
    (set timer
      (vim.defer_fn (fn []
        ;; Clear the timer
        (set timer nil)
        ;; Separate the getting of results and the rendering of results into
        ;; two passes to enable yeilding back for user input between them
        (let [results-co (coroutine.create get-results)
              write-co (coroutine.create write-results-inc)]
          ;; Run the search
          (local (status results) (coroutine.resume results-co search))
          (when status
            (do
              ;; Start the writer coroutine
              (coroutine.resume write-co results)
              ;; Continue writing until the coroutine is dead
              (while (~= (coroutine.status write-co) :dead)
                (coroutine.resume write-co)))))) on-update-debounce)))

  ;; Handles entering
  (fn on-enter []
    (local selected-values (core.vals selected))
    (if (= (core.count selected-values) 0)
      (let [[row _] (get-cursor) selection (get-cursor-line row)]
        (when (not= selection "")
          (config.on-select selection original-winnr)))
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
      (let [[row _] (get-cursor) selection (get-cursor-line row)]
        (when (not= selection "")
          (tset selected selection selection)
          (add-results-highlight row)))))

  ;; Handles unselect in the multiselect case
  (fn on-unselect []
    (when config.on-multiselect
      (let [[row _] (get-cursor) selection (get-cursor-line row)]
        (when (not= selection "")
          (tset selected selection nil)
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
  (local input-view-info (create-input-view
    {: layout
     : prompt
     : on-update
     : on-enter
     : on-exit
     : on-up
     : on-down
     : on-select
     : on-unselect
     : on-selectall}))

  ;; Register buffer for exiting
  (table.insert buffers input-view-info.bufnr)

  ;; Writes the results to the buffer
  (write-results initial-results))

