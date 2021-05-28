(module oldfiles {require {snap snap
                                oldfile snap.producer.vim.oldfile
                                fzy snap.consumer.fzy
                                file snap.select.file}})

(defn run [] (snap.run {:prompt "Old files"
                        :producer (fzy oldfile)
                        :select file.select}))

