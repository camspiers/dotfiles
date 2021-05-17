(module mappings {autoload {nvim aniseed.nvim
                            finder finder
                            file finder.file
                            cd finder.cd
                            oldfiles finder.oldfiles
                            buffer finder.buffer
                            grep finder.grep
                            tmuxinator finder.tmuxinator
                            tmux finder.tmux
                            wk which-key
                            terminal toggleterm.terminal
                            hover lspsaga.hover
                            codeaction lspsaga.codeaction
                            diagnostic lspsaga.diagnostic
                            trouble trouble}
                  require-macros [macros]})

(fn cmd-fmt [cmd]
  (string.format "<Cmd>%s<CR>" cmd))

(fn cmd [cmd name]
  [(cmd-fmt cmd) name])

(fn on_open [term]
  (vim.cmd :startinsert!)
  (nvim.buf_set_keymap term.bufnr :t :q (cmd-fmt :close)
                       {:noremap true :silent true}))

(fn open-git []
  (local lazygit (terminal.Terminal:new {:cmd (string.format "lazygit %s"
                                                             (vim.fn.getcwd))
                                         :hidden true
                                         :direction :float
                                         :float_opts {:border :curved}
                                         : on_open}))
  (lazygit:toggle))

(fn external-grep [word no-ignore]
  (let [word (or word (nvim.fn.input "Grep> "))]
    (if no-ignore
        (nvim.command (.. (.. "silent grep " word) " --no-ignore"))
        (nvim.command (.. "silent grep " word)))
    (nvim.command :copen)))

(fn external-grep-no-ignore [word]
  (grep false true))

(wk.register {:<leader>e [cd.run "Change Directory"]
              :<leader>c (cmd :clo "Close Window")
              :<leader>a (cmd :a :alternate)
              :<leader>n [external-grep :Grep]
              :<leader>N [external-grep-no-ignore "Grep with no ignore"]
              :<leader>m [grep.cursor "Grep cursor word"]
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
              :<leader><leader> [file.run "Find Files"]
              :<leader>h [oldfiles.run "Old files"]
              :<leader>b [buffer.run "Find Buffer"]
              :<leader>f [grep.run "Find in Files"]
              :<leader>p {:name "Project Management"
                          :s [tmuxinator.run "Start Project"]
                          :c [tmux.run "Switch Project"]
                          :l [open-git "Open Git"]}
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

