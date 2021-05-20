(fn cmd-fmt [cmd]
  (string.format "<Cmd>%s<CR>" cmd))

(fn augroup [name ...]
  `(do
     (nvim.ex.augroup ,(tostring name))
     (nvim.ex.autocmd_)
     ,...
     (nvim.ex.augroup :END)))

(fn autocmd [...]
  `(nvim.ex.autocmd ,...))

(fn sym-tostring [x]
  "convert variable's name to string"
  `,(tostring x))

(fn g [name value]
  "Set value for global Vim variable"
  (let [name-as-string (sym-tostring name)]
    `(tset vim.g ,name-as-string ,value)))

(fn get-scope [option]
  (if (pcall vim.api.nvim_get_option_info option)
      (let [info (vim.api.nvim_get_option_info option)]
        (if info.global_local :global_local info.scope))
      false))

(fn set-option [scope option value]
  (match scope
    :global `(vim.api.nvim_set_option ,option ,value)
    :global_local `(do
                     (vim.api.nvim_set_option ,option ,value)
                     (vim.api.nvim_buf_set_option 0 ,option ,value))
    :win `(vim.api.nvim_win_set_option 0 ,option ,value)
    :buf `(vim.api.nvim_buf_set_option 0 ,option ,value)
    _ `(print (.. "zest.se- invalid scope '" ,scope "' for option '" ,option
                  "'"))))

(fn se- [option value]
  (let [option (sym-tostring option)
        value (if (= value nil) true value)
        scope (get-scope option)]
    (if scope
        `,(set-option scope option value)
        (if (= (: option :sub 1 2) :no)
            (let [option (: option :sub 3)
                  scope (get-scope option)
                  value false]
              (if scope
                  `,(set-option scope option value)
                  `(print (.. "zest.se- option '" ,option "' not found"))))
            `(print (.. "zest.se- option '" ,option "' not found"))))))

{: augroup : autocmd : g : se-}

