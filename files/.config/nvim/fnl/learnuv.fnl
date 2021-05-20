(module learnuv {autoload {nvim aniseed.nvim core aniseed.core}})

(fn create-input [on-update]
  (local bufnr (nvim.create_buf false true))
  (local winnr (nvim.open_win bufnr 0
                              {:width 50
                               :height 1
                               :row 10
                               :col 20
                               :relative :editor
                               :anchor :NW
                               :border :single
                               :style :minimal}))
  (nvim.buf_set_option bufnr :buftype :prompt)
  (vim.fn.prompt_setprompt bufnr "Test> ")
  (nvim.command :startinsert)

  (fn get-filter []
    (let [contents (core.first (nvim.buf_get_lines bufnr 0 1 false))]
      (contents:sub (+ (length "Test> ") 1))))

  (fn on_lines []
    (on-update (get-filter)))

  (nvim.buf_attach bufnr false {: on_lines}))

(fn create-results [config]
  (local bufnr (nvim.create_buf false true))
  (local winnr (nvim.open_win bufnr 0
                              {:width 50
                               :height 30
                               :row 15
                               :col 20
                               :relative :editor
                               :anchor :NW
                               :border :single
                               :style :minimal}))
  (nvim.win_set_option winnr :cursorline true)
  (nvim.buf_set_option bufnr :buftype :prompt)
  {: bufnr : winnr})

(fn spawn [cmd args cwd]
  (var stdinbuffer "")
  (var stderrbuffer "")
  (let [stdout (vim.loop.new_pipe false)
        stderr (vim.loop.new_pipe false)
        handle (vim.loop.spawn cmd {: args :stdio [nil stdout stderr] : cwd}
                               (fn [code signal]
                                 (stdout:read_stop)
                                 (stderr:read_stop)
                                 (stdout:close)
                                 (stderr:close)
                                 (handle:close)))]
    (stdout:read_start (fn [err data]
                         (assert (not err))
                         (when data
                           (set stdinbuffer data))))
    (stderr:read_start (fn [err data]
                         (assert (not err))
                         (when data
                           (set stderrbuffer data))))

    (fn kill []
      (handle:kill vim.loop.constants.SIGTERM))

    (fn iterator []
      (if (and handle (handle:is_active))
          (let [current-stdin stdinbuffer
                current-stderr stderrbuffer]
            (set stdinbuffer "")
            (set stderrbuffer "")
            (values current-stdin current-stderr kill))
          nil))

    iterator))

(fn get-results [filter]
  (each [data err cancel (spawn :rg
                                [:--vimgrep :--block-buffered :--hidden filter]
                                (vim.fn.getcwd))]
    (let [(kill) (coroutine.yield data err)]
      (when kill
        (cancel)))))

(fn learn []
  (local {: create : resume : status} coroutine)
  (local {: bufnr} (create-results))

  (fn set-lines [start end lines]
    (nvim.buf_set_lines bufnr start end false lines))

  (fn write-results [results]
    (let [result-size (length results)]
      (if (= result-size 0)
          (set-lines 0 -1 [])
          (set-lines 0 -1 results))))

  (var last-filter nil)

  (fn on-update-unwraped [filter]
    (write-results [:Loading...])
    (set last-filter filter)
    (let [reader (create get-results)
          check (vim.loop.new_check)]
      (var stdinresult "")
      (local (_ stdin stderr) (resume reader filter))
      (when (not= stdin "")
        (set stdinresult (.. stdinresult stdin)))

      (fn parse-results []
        (local results (vim.split stdinresult "\n" true))
        (vim.schedule (partial write-results results)))

      (fn checker []
        (if (not= (status reader) :dead)
            (let [(_ stdin stderr) (resume reader (not= filter last-filter))]
              (if (not= stdin nil)
                  (when (not= stdin "")
                    (set stdinresult (.. stdinresult stdin)))
                  (do
                    (check:stop)
                    (when (= filter last-filter)
                      (parse-results)))))
            (do
              (check:stop)
              (parse-results))))

      ;; Schedule a checker after each IO poll
      (check:start checker)))

  (fn on-update [filter]
    (vim.schedule (partial on-update-unwraped filter)))

  (create-input on-update))

(def learn learn)

; (fn get-results [filter]
;   (local stdout (vim.loop.new_pipe false))
;   (local stderr (vim.loop.new_pipe false))
;   (local (handle pid) (vim.loop.spawn :rg
;                                       {:args [:--vimgrep
;                                               :--block-buffered
;                                               :--hidden
;                                               filter]
;                                        :stdio [nil stdout stderr]
;                                        :cwd (vim.fn.getcwd)}
;                                       (fn [code signal]
;                                         (stdout:read_stop)
;                                         (stderr:read_stop)
;                                         (stdout:close)
;                                         (stderr:close)
;                                         (handle:close))))
;   (var stdinbuffer "")
;   (var stderrbuffer "")
;   (stdout:read_start (fn [err data]
;                        (assert (not err))
;                        (when data
;                          (set stdinbuffer data))))
;   (stderr:read_start (fn [err data]
;                        (assert (not err))
;                        (when data
;                          (set stderrbuffer data))))
;   (while (and handle (handle:is_active))
;     (let [current-stdin stdinbuffer
;           current-stderr stderrbuffer]
;       (set stdinbuffer "")
;       (set stderrbuffer "")
;       (local (kill) (coroutine.yield current-stdin current-stderr))
;       (when kill
;         (handle:kill vim.loop.constants.SIGTERM)))))

