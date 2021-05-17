(module finder.grep {autoload {finder finder
                               utils finder.utils
                               config finder.config
                               nvim aniseed.nvim
                               astring aniseed.string
                               core aniseed.core}})

(fn get-results [filter]
  (if filter
      (utils.run (string.format "rg --vimgrep --hidden %s %s %q 2> /dev/null"
                                (config.gettypes) (config.getiglobs) filter))
      []))

(fn parse [line]
  (let [parts (astring.split line ":")]
    {:filename (. parts 1)
     :lnum (tonumber (. parts 2))
     :col (tonumber (. parts 3))
     :text (. parts 4)}))

(fn on-multiselect [lines winnr]
  (vim.fn.setqflist (core.map parse lines))
  (nvim.command :copen)
  (nvim.command :cfirst))

(fn on-select [line winnr]
  (let [{: filename : lnum : col} (parse line)]
    (print (vim.inspect [lnum col]))
    (let [buffer (nvim.fn.bufnr filename true)]
      (nvim.buf_set_option buffer :buflisted true)
      (nvim.win_set_buf winnr buffer)
      (nvim.win_set_cursor winnr [lnum col]))))

(defn run [] (finder.run {:prompt :Grep
                          : get-results
                          :on-filter get-results
                          : on-select
                          : on-multiselect}))

(defn cursor [] (finder.run {:prompt :Grep
                             :initial-filter (vim.fn.expand :<cword>)
                             : get-results
                             :on-filter get-results
                             : on-select
                             : on-multiselect}))

