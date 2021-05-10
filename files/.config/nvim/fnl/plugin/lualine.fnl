(module plugin.lualine {autoload {lualine lualine}})

;; Section a config
(local lualine-a {1 :mode})

;; Formatter for section a mode
(fn lualine_a.format [n]
  "Formatter for the mode in lualine"
  (string.sub n 1 1))

;; Set up lualine
(lualine.setup {:sections {:lualine_a [lualine-a]}
                :options {:theme :tokyonight
                          :section_separators ""
                          :component_separators ""}})

