;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   Finder   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; ~~~~~~~~~~~ A small fast extensible finder system for neovim. ~~~~~~~~~~~~ ;;
;;                                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                                            ;;
;; Requirements:                                                              ;;
;;                                                                            ;;
;;   - aniseed                                                                ;;
;;   - fzy (via luarocks, or just path accessible via 'fzy')                  ;;
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

;; Partition for quick sort
(fn partition [tbl p r comp]
  (let [x (. tbl r)]
    (var i (- p 1))
    (for [j p (- r 1) 1]
      (when (comp (. tbl j) x)
        (set i (+ i 1))
        (local temp (. tbl i))
        (tset tbl i (. tbl j))
        (tset tbl j temp)))
    (local temp (. tbl (+ i 1)))
    (tset tbl (+ i 1) (. tbl r))
    (tset tbl r temp)
    (+ i 1)))

;; Implementation of partial quicksort
;; For large amounts of results we can skip sorting the entire table

;; fnlfmt: skip
(defn partial-quicksort [tbl p r m comp]
  (when (< p r)
    (let [q (partition tbl p r comp)]
      (partial-quicksort tbl p (- q 1) m comp)
      (when (< p (- m 1))
        (partial-quicksort tbl (+ q 1) r m comp)))))

;; Global accessible layouts
;; Currently layouts always have the input placed below and therefore room
;; must be left available for it to fit
(def layouts {})

;; Helper to get lines
(fn layouts.lines []
  (nvim.get_option :lines))

;; Helper to get columns
(fn layouts.columns []
  (nvim.get_option :columns))

;; The middle for the height or width requested (from top or left)
(fn layouts.middle [total size]
  (math.floor (/ (- total size) 2)))

(fn layouts.from-bottom [size offset]
  (- (layouts.lines) size offset))

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
     :row (layouts.from-bottom height 8)
     :col (layouts.middle (layouts.columns) width)}))

(fn layouts.%top [%width %height]
  (let [{: width : height} (layouts.size %width %height)]
    {: width : height :row 5 :col (layouts.middle (layouts.columns) width)}))

;; Primary available layouts: centered, bottom, top

(fn layouts.centered []
  (layouts.%centered 0.8 0.5))

(fn layouts.bottom []
  (layouts.%bottom 0.8 0.5))

(fn layouts.top []
  (layouts.%top 0.8 0.5))

;; Stores mappings for buffers
(def fns {})

;; Cleans up unneeded buffer maps
(fn fns.clean [bufnr]
  (tset fns bufnr nil))

;; Provides ability to run fn
(fn fns.run [bufnr fnc]
  (when (?. fns bufnr fnc)
    ((. fns bufnr fnc))))

(fn fns.get-by-template [bufnr fnc pre post]
  (let [buf-fns (or (. fns bufnr) [])
        id (string.format "%s" fnc)]
    (tset fns bufnr buf-fns)
    (when (= (. buf-fns id) nil)
      (tset buf-fns id fnc))
    (string.format "%slua require'finder'.fns.run(%s, '%s')%s" pre bufnr id
                   post)))

;; Generates call signiture for maps
(fn fns.get-map-call [bufnr fnc]
  (fns.get-by-template bufnr fnc :<Cmd> :<CR>))

;; Generates call signiture for autocmds
(fn fns.get-autocmd-call [bufnr fnc]
  (fns.get-by-template bufnr fnc ":" ""))

;; Creates a buffer mapping and creates callable signiture
(fn fns.map [bufnr keys fnc]
  (let [rhs (fns.get-map-call bufnr fnc)]
    (each [_ key (ipairs keys)]
      (nvim.buf_set_keymap bufnr :n key rhs {})
      (nvim.buf_set_keymap bufnr :i key rhs {}))))

;; Modifies the basic window options to make the input sit below
(fn create-input-layout [layout]
  (let [{: width : height : row : col} (layout)]
    {: width :height 1 :row (+ height row 2) : col :focusable true}))

;; Creates a scratch buffer, used for both results and input
(fn create-buffer []
  (nvim.create_buf false true))

;; Creates a window with specified options

;; fnlfmt: skip
(fn create-window [bufnr {: width : height : row : col : focusable}]
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
(fn create-results-view [config]
  (let [bufnr (create-buffer)
        layout (config.layout)
        winnr (create-window bufnr layout)]
    (nvim.win_set_option winnr :cursorline true)
    (nvim.buf_set_option bufnr :buftype :prompt)
    {: bufnr : winnr :height layout.height :width layout.width}))

;; Creates the input buffer

;; fnlfmt: skip
(fn create-input-view [config]
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
        (if contents (contents:sub (+ (length config.prompt) 1)) "")))

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
      (config.on-select-all-toggle))

    (local on_lines (fn []
        (config.on-update (get-filter))))

    (fn on_detach [] 
      (fns.clean bufnr))

    (fns.map bufnr [:<CR>] on-enter)
    (fns.map bufnr [:<Up> :<C-k> :<C-p>] config.on-up)
    (fns.map bufnr [:<Down> :<C-j> :<C-n>] config.on-down)
    (fns.map bufnr [:<Esc> :<C-c>] on-exit)
    (fns.map bufnr [:<Tab>] on-tab)
    (fns.map bufnr [:<S-Tab>] on-shifttab)
    (fns.map bufnr [:<C-a>] on-ctrla)
    (fns.map bufnr [:<C-d>] config.on-pagedown)
    (fns.map bufnr [:<C-u>] config.on-pageup)

    (nvim.command "augroup Finder")
    (nvim.command (string.format "autocmd! WinLeave <buffer=%s> %s" bufnr (fns.get-autocmd-call bufnr on-exit)))
    (nvim.command "augroup END")

    (nvim.buf_attach bufnr false {: on_lines : on_detach})

    {: bufnr : winnr}))

;; Center text for loading screen
(fn center [text width]
  (let [space (string.rep " " (/ (- width (length text)) 2))]
    (.. space text space)))

;; Create a basic loading screen
(fn create-loading-screen [width height]
  (local loading [])
  (for [i 1 height]
    (if (= i (math.floor (/ height 2)))
        (table.insert loading (center "... Loading ..." (- width 2)))
        (table.insert loading (string.rep " " (- width 2)))))
  loading)

(fn score-compare [a b]
  (> a.score b.score))

;; Accumulates non empty results
(fn accumulate [results partial-results]
  (when (= (type partial-results) :string)
    (print partial-results))
  (when (not= partial-results nil)
    (each [_ value (ipairs partial-results)]
      (when (not= value "")
        (table.insert results value)))))

;; fnlfmt: skip
(defn cache [producer]
  "Provides a method to avoid running passed producer multiple times"
  (var cache [])
  (fn [message]
    (if (= (length cache) 0)
      (let [reader (coroutine.create producer)]
        (while (not= (coroutine.status reader) :dead)
          (local (_ results) (coroutine.resume reader message))
          (accumulate cache results)
          (coroutine.yield results)))
      cache)))

;; fnlfmt: skip
(defn filter [producer]
  "Filters each result from the producer using message.filter"
  (fn [message]
    (fn filter [results]
      (core.filter #(fzy.has_match message.filter $1) results))

    (let [reader (coroutine.create producer)]
      (while (not= (coroutine.status reader) :dead)
        (local (_ results) (coroutine.resume reader message))
        (coroutine.yield (if (= results nil) nil (filter results)))))))

;; fnlfmt: skip
(defn sort [producer]
  "Sorts the result set, please note this accumulates all results without yielding"
  (fn [message]
    (local buffer [])
    (local reader (coroutine.create producer))
    (while (not= (coroutine.status reader) :dead)
      (local (_ results) (coroutine.resume reader message))
      (when (not= results nil)
        (each [_ value (ipairs results)]
          (table.insert buffer
                        {: value :score (fzy.score message.filter value)}))))
    (partial-quicksort buffer 1 (length buffer) message.height score-compare)
    (coroutine.yield (core.map #$1.value buffer))))

;; fnlfmt: skip
(defn filter-sort [producer]
  "Combines the cache + filter + sort pattern for common uses"
  (sort (filter (cache producer))))

;; Run docs:
;;
;; @config: {
;;   "The prompt displayed to the user"
;;   :prompt string
;;
;;   "Get the results to display"
;;   :get-results () => itable<string>
;;
;;   "How to display the search results"
;;   :?layout (columns lines) => {
;;     :width number
;;     :height number
;;     :row number
;;     :col number
;;   }
;;
;;   "An optional boolean to enable filtering"
;;   :?filter boolean
;;
;;   "An optional function that enables multiselect executes on multiselect"
;;   :?on-multiselect (selections) => nil
;; }

;; fnlfmt: skip
(defn run [config]
  ;; Store last search
  (var last-filter nil)

  ;; Store the last results
  (var last-results [])

  ;; Exit flag tracks whether buffers have detatched
  ;; Used to send cancel message to get-results coroutines
  (var exit false)

  ;; Store buffers for exiting
  (local buffers [])

  ;; Default to the bottom layout
  (local layout (or config.layout layouts.bottom))

  ;; Store the initial filter
  (local initial-filter (or config.initial-filter ""))

  ;; Creates a namespace for highlighting
  (local namespace (nvim.create_namespace :Finder))

  ;; Stores the original window to so we can pass it back to the on-select function
  (local original-winnr (nvim.get_current_win))

  ;; Configures a default or custom prompt
  (local prompt (string.format "%s> " (or config.prompt :Find)))

  ;; Stores the selected items, used for multiselect
  (local selected {})

  ;; Get the cmd
  (local cwd (vim.fn.getcwd))

  ;; Handles exiting
  (fn on-exit []
    ;; Send the signal to exit to all potentially running processes in coroutines
    (set exit true)

    ;; Delete each open buffer
    (each [_ bufnr (ipairs buffers)]
      (when (nvim.buf_is_valid bufnr)
        (nvim.buf_delete bufnr {:force true})))

    ;; Return back to original window
    (nvim.set_current_win original-winnr)

    ;; Return back from insert mode
    (nvim.command :stopinsert))

  ;; Creates the results buffer and window and stores thier numbers
  (local view (create-results-view {: layout : on-exit}))

  ;; Register buffer for exiting
  (table.insert buffers view.bufnr)

  ;; Create a static loading screen (TODO think about dynamic loading screen API)
  (local loading-screen (create-loading-screen view.width view.height))

  ;; Helper function for highlighting
  (fn add-results-highlight [row]
    (nvim.buf_add_highlight view.bufnr namespace :Comment (- row 1) 0 -1))

  ;; Helper to set lines to results view
  (fn set-lines [start end lines]
    (nvim.buf_set_lines view.bufnr start end false lines))

  ;; Helper function for getting the cursor position
  (fn get-cursor-row [] (let [[row _] (nvim.win_get_cursor view.winnr)] row))

  ;; Helper function for getting the line under the cursor
  (fn get-cursor-line [row]
    (core.first (nvim.buf_get_lines view.bufnr (- row 1) row false)))

  ;; Only write what results are needed
  (fn write-results [results]
    (when (not exit)
      (let [result-size (length results)]
        (if (= result-size 0)
          ;; If there are no results then clear
          (set-lines 0 -1 [])
          ;; Otherwise render partial results
          (do
            ;; Don't render more than we need to
            ;; this is getting only the height plus the cursor
            (local partial-results [(unpack results 1 (+ view.height (get-cursor-row)))])
            (set-lines 0 -1 partial-results)
            (each [row line (pairs partial-results)]
              (when (. selected line) (add-results-highlight row))))))))

  ;; This is the non-scheduled version of on-update
  (fn on-update-unwraped [filter height]
    ;; Helper to determine if we should cancel, sent to coroutine
    ;; where it has the responsibility to kill running processes etc
    (fn should-cancel [] (or exit (not= filter last-filter)))

    ;; Counter used to control the loading screen
    (var counter 0)

    ;; Only run when the filter has changed
    (when (not= filter last-filter)
      ;; The last filter has changed
      (set last-filter filter)

      (let [reader (coroutine.create config.get-results)
            check (vim.loop.new_check)]
        ;; Prepare new results array for collection
        (local results [])

        ;; Update the cancel flag
        (local message {: filter
                        : height
                        : cwd
                        :cancel (should-cancel)
                        :slow-data (when config.get-slow-data (config.get-slow-data))})

        ;; Creates a writer scheduler with the results table in the closure
        (fn schedule-write []
          ;; Store the last written results
          (set last-results results)

          ;; Schedule the write
          (vim.schedule (partial write-results results)))

        ;; Run this whenever the checker should be considered to have ended
        (fn end []
          (check:stop)
          (when (not message.cancel)
            (schedule-write)))

        ;; This checker runs on every loop of the event loop
        ;; It checks if the coroutine is not dead and has more values
        (fn checker []
          ;; Increment the counter
          (set counter (+ counter 1))

          ;; Update the cancel flag
          (tset message :cancel (should-cancel))

          ;; Render a basic loading screen
          ;; but oly if loading has taken two ticks
          (when (= counter 2)
            (vim.schedule (partial write-results loading-screen)))

          ;; When the coroutine is not dead, process its results
          (if (not= (coroutine.status reader) :dead)
            ;; Fetches results be also sends cancel signal
            (let [(_ partial-results) (coroutine.resume reader message)]
              (when (= (type partial-results) "string") (print "Table not returned: " partial-results))
              ;; When there is nil the coroutine has reached its last value
              (if (not= partial-results nil)
                ;; Store the values, there are more to come
                (accumulate results partial-results)
                ;; The coroutine is dead so stop the checker and schedule a write
                (end)))
            ;; When the coroutine is dead then stop the checker and write
            (end)))

        ;; Start the checker after each IO poll
        (check:start checker))))

  ;; You can't immediately start the checker so schedule
  (fn on-update [filter]
    (vim.schedule (partial on-update-unwraped filter view.height)))

  ;; Handles entering
  (fn on-enter []
    (local selected-values (core.vals selected))
    (if (= (core.count selected-values) 0)
      (let [row (get-cursor-row) selection (get-cursor-line row)]
        (when (not= selection "")
          (config.on-select selection original-winnr)))
      (when config.on-multiselect (config.on-multiselect selected-values original-winnr))))

  ;; Handles select all in the multiselect case
  (fn on-select-all-toggle []
    (when config.on-multiselect
      (each [_ value (ipairs last-results)]
        (if (= (. selected value) nil)
          (tset selected value value)
          (tset selected value nil)))
      (write-results last-results)))

  ;; Handles select in the multiselect case
  (fn on-select-toggle []
    (when config.on-multiselect
      (let [row (get-cursor-row) selection (get-cursor-line row)]
        (when (not= selection "")
          (if (= (. selected selection) nil)
            (do 
              (tset selected selection selection)
              (add-results-highlight row))
            (do
              (tset selected selection nil)
              (nvim.buf_clear_namespace view.bufnr namespace (- row 1) row)))))))

  ;; On key helper
  (fn on-key-direction [get-next-index]
    (let [row (get-cursor-row) index (get-next-index row)]
      (nvim.win_set_cursor view.winnr
        [(math.max 1 (math.min (nvim.buf_line_count view.bufnr) index)) 0])
      (write-results last-results)))

  ;; On up handler
  (fn on-up []
    (on-key-direction core.dec))

  ;; On down handler
  (fn on-down []
    (on-key-direction core.inc))
 
  ;; Page up handler
  (fn on-pageup []
    (on-key-direction #(- $1 view.height)))

  ;; Page down handler
  (fn on-pagedown []
    (on-key-direction #(+ $1 view.height)))

  ;; Initializes the input view
  (local input-view-info (create-input-view
    {: initial-filter
     : layout
     : prompt
     : on-enter
     : on-exit
     : on-up
     : on-down
     : on-pageup
     : on-pagedown
     : on-select-toggle
     : on-select-all-toggle
     : on-update}))

  ;; Register buffer for exiting
  (table.insert buffers input-view-info.bufnr))

