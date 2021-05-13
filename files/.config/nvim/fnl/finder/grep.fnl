(module finder.grep {autoload {finder finder
                               nvim aniseed.nvim
                               astring aniseed.string
                               core aniseed.core}})

(fn query [filter]
  (string.format "rg --vimgrep --hidden --iglob '!.DS_Store' --iglob '!.git' '%s' 2> /dev/null"
                 filter))

(fn get-results [filter]
  (if (not= filter "")
      (let [file (io.popen (query filter) :r)
            contents (file:read :*all)]
        (file:close)
        (core.filter #(not= $1 "") (astring.split contents "\n")))
      []))

(fn parse [line]
  (let [parts (astring.split line ":")]
    {:filename (. parts 1) :lnum (. parts 2) :col (. parts 3)}))

(defn- on-select [line winnr] (vim.fn.setqflist [(parse line)])
       (nvim.command :copen) (nvim.command :cfirst))

(defn- on-multiselect [lines winnr] (vim.fn.setqflist (core.map parse lines))
       (nvim.command :copen) (nvim.command :cfirst))

(local prompt :Grep)

(defn find [] (finder.run {: prompt
                           : get-results
                           : on-select
                           : on-multiselect
                           :filter false}))

