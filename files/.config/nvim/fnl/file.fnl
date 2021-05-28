(module file {require {snap snap}})

(defn run [] (snap.run {:prompt :Files
                        :producer ((snap.get :consumer.fzy) (snap.get :producer.ripgrep.file))
                        :select (. (snap.get :select.file) :select)
                        :multiselect (. (snap.get :select.file) :multiselect)
                        :preview (snap.get :preview.file)}))

