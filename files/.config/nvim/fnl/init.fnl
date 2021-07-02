(module init {autoload {nvim aniseed.nvim}})

(require :options)
(require :plugins)
(require :mappings)

(vim.api.nvim_command "autocmd Filetype fennel setlocal syntax=")

