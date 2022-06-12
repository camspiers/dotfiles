(module plugin.lualine {autoload {lualine lualine}})

;; Section a config
(local lualine-a {1 :mode})

;; Formatter for section a mode
(fn lualine-a.fmt [n]
  "Formatter for the mode in lualine"
  (string.sub n 1 1))

;; Section c config
(local lualine-c {1 :filename :path 1})

;; Set up lualine
(lualine.setup {:sections {:lualine_a [lualine-a] :lualine_c [lualine-c]}
                :options {:globalstatus true
                          :theme :tokyonight
                          :section_separators ""
                          :component_separators ""}})

