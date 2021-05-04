{:augroup (fn [name ...]
            `(do
               (nvim.ex.augroup ,(tostring name))
               (nvim.ex.autocmd_)
               ,...
               (nvim.ex.augroup :END)))
 :autocmd (fn [...]
            `(nvim.ex.autocmd ,...))}

