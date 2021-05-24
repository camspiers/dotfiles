(module plugin.formatter {autoload {nvim aniseed.nvim formatter formatter}
                          require-macros [macros]})

;; Register formatters into a table
(local formatters {})

(fn formatters.prettier []
  "The prettier formatter"
  {:exe :prettier :args [:--stdin-filepath (nvim.buf_get_name 0)] :stdin true})

(fn formatters.luaformat []
  "The lua formattter"
  {:exe :lua-format :args [:--indent-width 2 :--tab-width 2] :stdin true})

(fn formatters.fnlfmt []
  "The fennel formatter"
  {:exe :fnlfmt :args [(nvim.buf_get_name 0)] :stdin true})

;; Set up file formatting 
(formatter.setup {:filetype {:typescriptreact [formatters.prettier]
                             :typescript [formatters.prettier]
                             :lua [formatters.luaformat]
                             :fennel [formatters.fnlfmt]}})

;; Register autocommands for file formatting on save
(augroup formatter_autogroup
         (autocmd :BufWritePost "*.ts,*.tsx,*.lua" :FormatWrite))

