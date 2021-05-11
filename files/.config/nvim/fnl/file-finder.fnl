(module file-finder {autoload {finder finder nvim aniseed.nvim}})

(local find_command "rg --files --hidden --iglob !.DS_Store --iglob !.git")
(local find_all_command (.. find_command " --no-ignore -tjs"))
(defn- get-results-raw [cmd] (let [file (assert (io.popen cmd :r))
                                   contents (file:read :*all)]
                               (file:close)
                               contents))

(defn- get-results [cmd] (local results-raw (get-results-raw cmd))
       (local results [])
       (each [contents (string.gmatch results-raw "[^\r\n]+")]
         (table.insert results contents)) results)

(defn- open-file [file winnr]
       (let [buffer (nvim.fn.bufnr file true)]
         (nvim.buf_set_option buffer :buflisted true)
         (when (not= winnr false)
           (nvim.win_set_buf winnr buffer))))

(defn- open-files [files winnr] (print :hi)
       (each [index file (ipairs files)]
         (open-file file (if (= (length files) index) winnr false))))

(defn find [] (finder.run {:prompt "Find Files"
                           :get-results (partial get-results find_command)
                           :on-select open-file
                           :on-multiselect open-files}))

(defn find-all [] (finder.run {:prompt "Find All Files"
                               :get-results (partial get-results
                                                     find_all_command)
                               :on-select open-file}))

