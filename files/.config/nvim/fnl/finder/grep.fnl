(module finder.grep {autoload {finder finder
                               config finder.config
                               nvim aniseed.nvim
                               astring aniseed.string
                               core aniseed.core}})

(fn get-results [filter]
  (if filter
      (finder.cmd.run (string.format "rg --vimgrep --hidden %s %s %q 2> /dev/null"
                                     (config.gettypes) (config.getglobs) filter))
      []))

(fn parse [line]
  (let [parts (astring.split line ":")]
    {:filename (. parts 1)
     :lnum (. parts 2)
     :col (. parts 3)
     :text (. parts 4)}))

(defn- on-select [line winnr] (vim.fn.setqflist [(parse line)])
       (nvim.command :copen) (nvim.command :cfirst))

(defn- on-multiselect [lines winnr] (vim.fn.setqflist (core.map parse lines))
       (nvim.command :copen) (nvim.command :cfirst))

(local prompt "Live Grep")

(defn run [] (finder.run {: prompt
                          : get-results
                          :on-filter get-results
                          : on-select
                          : on-multiselect}))

