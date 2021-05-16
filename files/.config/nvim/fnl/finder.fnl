;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   Finder   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; ~~~~~~~~~~ A small fast extensible finder system for neovim. ~~~~~~~~~~~~~ ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; Requirements:                                                              ;;
;;                                                                            ;;
;;   - aniseed                                                                ;;
;;   - fzf (via luarocks, or just path accessible via 'fzy')                  ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; Example:                                                                   ;;
;;                                                                            ;;
;; (finder.run {:prompt "Print One or Two"                                    ;;
;;              :get-results (fn [] [:One :Two])                              ;;
;;              :on-select print})                                            ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(module finder {autoload {nvim aniseed.nvim core aniseed.core}
                require {fzy fzy}})

;; Global accessible layouts
;; Currently layouts always have the input placed below and therefore room
;; must be left available for it to fit
(def layouts {})

(fn layouts.lines []
  (nvim.get_option :lines))

(fn layouts.columns []
  (nvim.get_option :columns))

(fn layouts.middle [total size]
  (math.floor (/ (- total size) 2)))

(fn layouts.from-bottom [size offset]
  (- (layouts.lines) size offset))

(fn layouts.from-right [size offset]
  (- (layouts.columns) size offset))

(fn layouts.size [%width %height]
  {:width (math.floor (* (layouts.columns) %width))
   :height (math.floor (* (layouts.lines) %height))})

(fn layouts.%centered [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width
     : height
     :row (layouts.middle (layouts.lines) height)
     :col (layouts.middle (layouts.columns) width)}))

(fn layouts.%bottom [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width
     : height
     :row (layouts.from-bottom height 10)
     :col (layouts.middle (layouts.columns) width)}))

(fn layouts.%top [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width : height :row 5 :col (layouts.middle (layouts.columns) width)}))

(fn layouts.%left [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width : height :row (layouts.middle (layouts.lines) height) :col 5}))

(fn layouts.%right [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width
     : height
     :row (layouts.middle (layouts.lines) height)
     :col (layouts.from-right width 5)}))

(fn layouts.centered []
  (layouts.%centered 0.8 0.5))

(fn layouts.bottom []
  (layouts.%bottom 0.8 0.5))

(fn layouts.top []
  (layouts.%top 0.8 0.5))

(fn layouts.left []
  (layouts.%left 0.5 0.5))

(fn layouts.right []
  (layouts.%right 0.5 0.5))

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

;; Generates call signiture for maps
(fn fns.get-map-call [bufnr fnc]
  (fns.get-by-template bufnr fnc
                       "<Cmd>lua require'finder'.fns.run(%s, '%s')<CR>"))

;; Generates call signiture for autocmds
(fn fns.get-autocmd-call [bufnr fnc]
  (fns.get-by-template bufnr fnc ":lua require'finder'.fns.run(%s, '%s')"))

;; Creates a buffer mapping and creates callable signiture
(fn fns.map [bufnr keys fnc]
  (let [rhs (fns.get-map-call bufnr fnc)]
    (each [_ key (ipairs keys)]
      (nvim.buf_set_keymap bufnr :n key rhs {})
      (nvim.buf_set_keymap bufnr :i key rhs {}))))

;; Modifies the basic window options to make the input sit below

;; fnlfmt: skip
(defn- create-input-layout [layout]
  (let [{: width : height : row : col} (layout)]
    {: width :height 1 :row (+ height row 2) : col :focusable true}))

;; Creates a scratch buffer, used for both results and input
(defn- create-buffer [] (nvim.create_buf false true))

;; Creates a window with specified options

;; fnlfmt: skip
(defn- create-window [bufnr {: width : height : row : col : focusable}]
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
        winnr (create-window bufnr (config.layout))]
    (nvim.win_set_option winnr :cursorline true)
    (nvim.buf_set_option bufnr :buftype :prompt)
    {: bufnr : winnr}))

;; Creates the input buffer

;; fnlfmt: skip
(defn- create-input-view [config]
  (let [bufnr (create-buffer)
        winnr (create-window bufnr (create-input-layout config.layout))]
    (nvim.buf_set_option bufnr :buftype :prompt)
    (vim.fn.prompt_setprompt bufnr config.prompt)
    (nvim.command :startinsert)

    (when (~= config.initial-filter "")
      ;; We do it this way because prompts are broken in nvim
      (nvim.feedkeys config.initial-filter :n false))

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
      (config.on-select-toggle)
      (config.on-down))

    (fn on-shifttab []
      (config.on-select-toggle)
      (config.on-up))

    (fn on-ctrla []
      (config.on-select-all-toggle (get-filter)))

    (var mounted false)
    (fn on_lines []
      (if mounted
        (config.on-update (get-filter))
        (set mounted true)))

    (fn on_detach [] 
      (fns.clean bufnr))

    (fns.map bufnr [:<CR>] on-enter)
    (fns.map bufnr [:<Up> :<C-k> :<C-p>] config.on-up)
    (fns.map bufnr [:<Down> :<C-j> :<C-n>] config.on-down)
    (fns.map bufnr [:<Esc> :<C-c>] on-exit)
    (fns.map bufnr [:<Tab>] on-tab)
    (fns.map bufnr [:<S-Tab>] on-shifttab)
    (fns.map bufnr [:<C-a>] on-ctrla)

    (nvim.command "augroup Finder")
    (nvim.command (string.format "autocmd! WinLeave <buffer=%s> %s" bufnr (fns.get-autocmd-call bufnr on-exit)))
    (nvim.command "augroup END")

    (nvim.buf_attach bufnr false {: on_lines : on_detach})

    {: bufnr : winnr}))

;; Helper function
(fn partition [size tbl]
  (var current 0)
  (local tbl-length (length tbl))
  (fn []
    (let [start (* current size)
          next (+ current 1)
          end (* next size)
          chunk [(unpack tbl (+ start 1) end)]]
      (set current next)
      (if (= 0 (length chunk)) nil (values current chunk (>= end tbl-length))))))

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
  (local on-update-debounce 75)

  ;; Default render chunk size
  (local render-chunk-size 50)

  ;; Default to the bottom layout
  (local layout (or config.layout layouts.bottom))

  ;; Store buffers for exiting
  (local initial-filter (or config.initial-filter ""))

  ;; Computes the initial results
  (local initial-results (config.get-results))

  ;; Creates a namespace for highlighting
  (local namespace (nvim.create_namespace :Finder))

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

  ;; Helper to set lines to results view
  (fn set-lines [start end lines]
    (nvim.buf_set_lines results-view-info.bufnr start end false lines))

  ;; Incremental writes
  (fn write-results [results]
    (let [result-size (length results)]
      (if (= result-size 0)
        ;; If there are no results then clear
        (set-lines 0 -1 [])
        ;; Otherwise render the chunks
        (do
          (each [index chunk last (partition render-chunk-size results)]
            (let [size (length chunk) end (* index size)]
              ;; Render the chunks lines
              (set-lines (* (- index 1) render-chunk-size) end chunk)
              ;; If we are on the last chunk clear all content past its last entry
              (when last (set-lines end -1 [])))
            (coroutine.yield))
          (each [row line (pairs results)]
            (when (. selected line) (add-results-highlight row)))))))

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
        (if (= search "")
          initial-results
          (do
            (local results-table
              (icollect [_ value (ipairs initial-results)]
                (when (fzy.has_match search value)
                  {: value :score (fzy.score search value)})))
            (table.sort results-table #(> $1.score $2.score))
            (core.map #(. $1 :value) results-table))))))
          

  ;; Debouncing
  (var timer nil)

  ;; Update function, called when the filter changes
  (fn on-update [search]
    ;; Clear the timer
    (set timer nil)
    ;; Separate the getting of results and the rendering of results into
    ;; two passes to enable yeilding back for user input between them
    (let [results-co (coroutine.create get-results)
          write-co (coroutine.create write-results)]
      ;; Run the search
      (local (status results) (coroutine.resume results-co search))
      (when status
        (do
          ;; Start the writer coroutine
          (coroutine.resume write-co results)
          ;; Continue writing until the coroutine is dead
          (while (~= (coroutine.status write-co) :dead)
            (coroutine.resume write-co))))))

  ;; Debounced version
  (fn on-update-debounced [search]
    ;; Redraw for quick updating of input
    (nvim.command :redraw)
    ;; When a new update comes and there is still a timer then cancel it
    (when timer (vim.loop.timer_stop timer))
    ;; Store a timer for stopping. This is a debounce strategy
    (set timer (vim.defer_fn (partial on-update search) on-update-debounce)))

  ;; Handles entering
  (fn on-enter []
    (local selected-values (core.vals selected))
    (if (= (core.count selected-values) 0)
      (let [[row _] (get-cursor) selection (get-cursor-line row)]
        (when (not= selection "")
          (config.on-select selection original-winnr)))
      (when config.on-multiselect (config.on-multiselect selected-values original-winnr))))

  ;; Handles select all in the multiselect case
  (fn on-select-all-toggle [search]
    (when config.on-multiselect
      (each [_ value (ipairs (get-results search))]
        (if (= (. selected value) nil)
          (tset selected value value)
          (tset selected value nil)))
      (on-update search)))

  ;; Handles select in the multiselect case
  (fn on-select-toggle []
    (when config.on-multiselect
      (let [[row _] (get-cursor) selection (get-cursor-line row)]
        (when (not= selection "")
          (if (= (. selected selection) nil)
            (do 
              (tset selected selection selection)
              (add-results-highlight row))
            (do
              (tset selected selection nil)
              (nvim.buf_clear_namespace results-view-info.bufnr namespace (- row 1) row)))))))

  ;; On key helper
  (fn on-key-direction [cond get-row]
    (let [[row _] (get-cursor)]
      (when (cond row)
        (nvim.win_set_cursor results-view-info.winnr [(get-row row) 0])
        (nvim.command "redraw!"))))

  ;; On up handler
  (fn on-up []
    (on-key-direction #(> $1 1) #(- $1 1)))

  ;; On down handler
  (fn on-down []
    (on-key-direction #(< $1 (nvim.buf_line_count results-view-info.bufnr)) #(+ $1 1)))

  ;; Initializes the input view
  (local input-view-info (create-input-view
    {: initial-filter
     : layout
     : prompt
     : on-enter
     : on-exit
     : on-up
     : on-down
     : on-select-toggle
     : on-select-all-toggle
     :on-update on-update-debounced}))

  ;; Register buffer for exiting
  (table.insert buffers input-view-info.bufnr)

  ;; Writes the results to the buffer
  (on-update-debounced initial-filter))

