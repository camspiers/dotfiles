(module plugin.treesitter {autoload {config nvim-treesitter.configs}})

(config.setup {:highlight {:enable true
                           :additional_vim_regex_highlighting {:fennel false}}})
