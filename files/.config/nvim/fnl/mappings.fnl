(module mappings {autoload {nvim aniseed.nvim
                            finder finder
                            wk which-key
                            telescope telescope
                            themes telescope.themes
                            terminal toggleterm.terminal
                            telescope_builtin telescope.builtin
                            hover lspsaga.hover
                            codeaction lspsaga.codeaction
                            diagnostic lspsaga.diagnostic
                            trouble trouble
                            utils utils}
                  require-macros [macros]})

(local find_command [:rg
                     :--files
                     :--hidden
                     :--iglob
                     :!.DS_Store
                     :--iglob
                     :!.git])

(fn call [cmd]
  (let [file (assert (io.popen cmd :r))
        contents (file:read :*all)]
    (file:close)
    contents))

(fn get-from-command [cmd]
  (local results-raw (call cmd))
  (local results [])
  (each [contents (string.gmatch results-raw "[^\r\n]+")]
    (table.insert results contents))
  results)

(fn open-file [selection winnr]
  (let [buffer (nvim.fn.bufnr selection true)]
    (nvim.buf_set_option buffer :buflisted true)
    (nvim.win_set_buf winnr buffer)))

(local find-config {:prompt "Find Files"
                    :get-results (partial get-from-command
                                          (table.concat find_command " "))
                    :on-enter open-file})

(local find-all-config {:prompt "Find All Files"
                        :get-results (partial get-from-command
                                              (.. (table.concat find_command
                                                                " ")
                                                  " --no-ignore"))
                        :on-enter open-file})

(fn cmd-fmt [cmd]
  (string.format "<Cmd>%s<CR>" cmd))

(fn cmd [cmd name]
  [(cmd-fmt cmd) name])

(fn projects []
  (telescope.extensions.tmuxinator.projects (themes.get_dropdown {})))

(fn on_open [term]
  (vim.cmd :startinsert!)
  (utils.buf-map term.bufnr :t :q (cmd-fmt :close) {:noremap true :silent true}))

(local lazygit (terminal.Terminal:new {:cmd :lazygit
                                       :hidden true
                                       :direction :float
                                       :float_opts {:border :curved}
                                       : on_open}))

(fn open-git []
  (lazygit:toggle))

(fn get-cursor-word []
  (vim.fn.expand :<cword>))

(fn grep [word no-ignore]
  (let [word (or word (nvim.fn.input "Grep> "))]
    (if no-ignore
        (nvim.command (.. (.. "silent grep " word) " --no-ignore"))
        (nvim.command (.. "silent grep " word)))
    (nvim.command :copen)))

(fn grep-no-ignore [word]
  (grep false true))

(fn grep-cursor-word []
  (grep (get-cursor-word)))

(fn grep-cursor-word-no-ignore []
  (grep (get-cursor-word) true))

(wk.register {:<leader>n [grep :Grep]
              :<leader>N [grep-no-ignore "Grep with no ignore"]
              :<leader>m [grep-cursor-word "Grep cursor word"]
              :<leader>M [grep-cursor-word-no-ignore
                          "Grep cursor word no ignore"]
              :<leader>w (cmd :w "Buffer Write")
              :<Tab> (cmd :bn "Buffer Next")
              :<S-Tab> (cmd :bp "Buffer Prev")
              :<leader>x (cmd :bd "Buffer Delete")
              :<leader><S-x> (cmd :bd! "Buffer Delete (!)")
              :<leader>z (cmd "%bd" "Buffer Delete All")
              :<leader><S-z> (cmd "%bd!" "Buffer Delete All (!)")
              :<leader>| (cmd :vs "Split Vertical")
              :<leader>- (cmd :sp "Split Horizontal")
              :<leader>c (cmd :clo "Close Window")
              :<leader><S-c> (cmd "%clo" "Close All Windows")
              :<leader>o (cmd :on "Only Window")
              :<leader><leader> [(partial finder.run find-config) "Find Files"]
              "<leader><C-\\>" [(partial finder.run find-all-config)
                                "Find All Files"]
              :<leader>b [telescope_builtin.buffers "Find Buffer"]
              :<leader>f [telescope_builtin.live_grep "Find in Files"]
              :<leader>p {:name "Project Management"
                          :s [projects "Start Project"]
                          :l [open-git "Open Git"]}
              :* {:name "Cursor Find"
                  :* ["*" "Find Next in Document"]
                  :f [telescope_builtin.grep_string "Find by Grep"]}
              :<leader>l {:name "Language Server Provider"
                          :d [vim.lsp.buf.definition "Go to definition"]
                          :D [vim.lsp.buf.declaration "Go to declaration"]
                          :r [vim.lsp.buf.references "Go to references"]
                          :i [vim.lsp.buf.implementation
                              "Go to implementation"]
                          :h [hover.render_hover_doc "Hover doc"]
                          :a [codeaction.code_action "Code action"]
                          :p [diagnostic.lsp_jump_diagnostic_prev
                              "Diagnostic Prev"]
                          :n [diagnostic.lsp_jump_diagnostic_next
                              "Diagnostic Next"]}
              :<leader>t {:name :Trouble
                          :t [trouble.toggle "Trouble Toggle"]
                          :w [(partial trouble.toggle
                                       :lsp_workspace_diagnostics)
                              "LSP Workspace Diagnostics"]
                          :d [(partial trouble.toggle :lsp_document_diagnostics)
                              "LSP Document Diagnostics"]
                          :q [(partial trouble.toggle :quickfix)
                              "Quickfix List"]
                          :l [(partial trouble.toggle :loclist)
                              "Location List"]}})

(wk.register {:gc [":<c-u>call CommentOperator(visualmode())<cr>"
                   "Comment Code"]} {:mode :v})

