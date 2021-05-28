(module grep {require {snap snap
                            io snap.io
                            vimgrep snap.producer.ripgrep.vimgrep
                            vimgrep-select snap.select.vimgrep
                            limit snap.consumer.limit}})

(defn run [] (snap.run {:prompt :Grep
                        :producer (limit 10000 vimgrep)
                        :select vimgrep-select.select
                        :multiselect vimgrep-select.multiselect}))

(defn cursor [] (snap.run {:prompt :Grep
                           :initial-filter (vim.fn.expand :<cword>)
                           :producer vimgrep
                           :select vimgrep-select.select
                           :multiselect vimgrep-select.multiselect}))

