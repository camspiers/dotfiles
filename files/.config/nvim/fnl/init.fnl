(module init {autoload {nvim aniseed.nvim}})

(require :options)
(require :plugins)
(require :mappings)

;; Ensure the intro screen displays
; (when (= (nvim.buf_get_name 0) "")
;   (vim.cmd :intro))

