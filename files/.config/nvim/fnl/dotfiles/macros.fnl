(fn g [name value]
  "Set value for global Vim variable"
  `(tset vim.g ,name ,value))

(fn set-opt [scope name value]
  (assert (sym? name))
  (let [full-opt (view name)
        len (length full-opt)
        opt (if (full-opt:match "[-+^!]$") (full-opt:sub 1 (- len 1)) full-opt)]
    (match (full-opt:sub len)
      "-" (assert false "not implemented")
      "^" `(let [v# ,value]
             (tset ,scope ,opt
                   (if (= (. ,scope ,opt) "") v# (.. v# "," (. ,scope ,opt)))))
      "+" `(let [v# ,value]
             (tset ,scope ,opt
                   (if (= (. ,scope ,opt) "") v# (.. (. ,scope ,opt) "," v#))))
      _ `(tset ,scope ,opt ,(or value true)))))

(fn opt [name value]
  "Set Vim option"
  (set-opt `vim.o name value))

(fn wopt [name value]
  "Set Vim window option"
  (set-opt `vim.wo name value))

(fn bopt [name value]
  "Set Vim buffer option"
  (set-opt `vim.bo name value))

(fn translate-opts [opts]
  (let [flags (icollect [k v (pairs opts)]
                (match k
                  :bar (when v
                         :-bar)
                  :bang (when v
                          :-bang)
                  :register (when v
                              :-register)
                  :buffer (when v
                            :-buffer)
                  :range (.. :-range= v)
                  :addr (.. :-addr= v)
                  :complete (.. :-complete= v)
                  :nargs (.. :-nargs= v)))]
    (table.concat flags " ")))

(fn augroup [name ...]
  `(do
     (nvim.ex.augroup ,(tostring name))
     (nvim.ex.autocmd_)
     ,...
     (nvim.ex.augroup :END)))

(fn autocmd [...]
  `(nvim.ex.autocmd ,...))

{: augroup : autocmd : g : on : opt : bopt : wopt}

