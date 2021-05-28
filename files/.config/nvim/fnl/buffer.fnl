(module buffer {require {snap snap
                              buffer snap.producer.vim.buffer
                              fzy snap.consumer.fzy
                              file snap.select.file}})

(defn run [] (snap.run {:prompt :Buffers
                        :producer (fzy buffer)
                        :select file.select}))

