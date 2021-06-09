(module plugin.snap {autoload {snap snap}})

;; Small actions system
(local actions {})

;; Adds an action
(defn action [name action] (tset actions name action))

(let [fzy (snap.get :consumer.fzy)
      fzf (snap.get :consumer.fzf)
      limit (snap.get :consumer.limit)
      producer-file (snap.get :producer.ripgrep.file)
      producer-jumplist (snap.get :producer.vim.jumplist)
      producer-git (snap.get :producer.git.file)
      producer-luv-file (snap.get :producer.luv.file)
      producer-vimgrep (snap.get :producer.ripgrep.vimgrep)
      producer-buffer (snap.get :producer.vim.buffer)
      producer-currentbuffer (snap.get :producer.vim.currentbuffer)
      producer-oldfile (snap.get :producer.vim.oldfile)
      select-file (snap.get :select.file)
      select-jumplist (snap.get :select.jumplist)
      select-vimgrep (snap.get :select.vimgrep)
      select-currentbuffer (snap.get :select.currentbuffer)
      preview-file (snap.get :preview.file)
      preview-vimgrep (snap.get :preview.vimgrep)
      preview-jumplist (snap.get :preview.jumplist)]

  ;; File finder
  (snap.register.map
    [:n]
    [:<Leader><Leader>]
    (fn []
      (snap.run {:prompt :Files
                 :producer (fzy producer-file)
                 :select select-file.select
                 :multiselect select-file.multiselect
                 :views [preview-file]})))

  (snap.register.map
    [:n]
    [:<Leader>1]
    (fn []
      (snap.run {:prompt :Files
                 :producer (fzf producer-file)
                 :select select-file.select
                 :multiselect select-file.multiselect
                 :views [preview-file]})))

  (snap.register.map
    [:n]
    [:<Leader>fg]
    (fn []
      (snap.run {:prompt :Git
                 :producer (fzy producer-git)
                 :select select-file.select
                 :multiselect select-file.multiselect
                 :views [preview-file]})))

  (snap.register.map
    [:n]
    [:<Leader>fj]
    (fn []
      (snap.run {:prompt :Jumplist
                 :producer (fzy producer-jumplist)
                 :select select-jumplist.select
                 :views [preview-jumplist]})))

  ;; Grep
  (snap.register.map
    [:n]
    [:<Leader>ff]
    (fn []
      (snap.run {:prompt :Grep
                 :producer (limit 50000 producer-vimgrep)
                 :select select-vimgrep.select
                 :multiselect select-vimgrep.multiselect
                 :views [preview-vimgrep]})))

  ;; Buffers
  (snap.register.map
    [:n]
    [:<Leader>fb]
    (fn []
      (snap.run {:prompt :Buffers
                 :producer (fzy producer-buffer)
                 :select select-file.select
                 :multiselect select-file.multiselect
                 :views [preview-file]})))

  ;; Oldfiles
  (snap.register.map
    [:n]
    [:<Leader>fo]
    (fn []
      (snap.run {:prompt :Oldfiles
                 :producer (fzy producer-oldfile)
                 :select select-file.select
                 :multiselect select-file.multiselect
                 :views [preview-file]})))

  ;; Grep cursor
  (snap.register.map
    [:n]
    [:<Leader>m]
    (fn []
      (snap.run {:prompt :Grep
                 :initial_filter (vim.fn.expand :<cword>)
                 :producer (limit 10000 producer-vimgrep)
                 :select select-vimgrep.select
                 :multiselect select-vimgrep.multiselect
                 :views [preview-vimgrep]})))
 
  ;; Action system
  (snap.register.map
    [:n]
    [:<Leader>fa]
    (fn []
      (snap.run {:prompt :Action
                 :producer (fzy (fn [] (vim.tbl_keys actions)))
                 :select (fn [action] (vim.schedule (. actions (tostring action))))}))))
