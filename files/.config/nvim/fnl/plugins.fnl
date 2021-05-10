(module plugins {autoload {packer packer nvim aniseed.nvim core aniseed.core}
                 require-macros [macros]})

;; Curtesy of Olical
(defn safe-require-plugin-config [name]
      (let [(ok? val-or-err) (pcall require (.. :plugin. name))]
        (when (not ok?)
          (print (.. "dotfiles error: " val-or-err)))))

;; Curtesy of Olical
(defn- use [...] "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
       (let [pkgs [...]]
         (packer.startup (fn [use use-rocks]
                           (for [i 1 (core.count pkgs) 2]
                             (let [name (. pkgs i)
                                   opts (. pkgs (+ i 1))]
                               (-?> (. opts :mod) (safe-require-plugin-config))
                               (if (. opts :rock)
                                   (use-rocks name)
                                   (use (core.assoc opts 1 name)))))))))

;; fnlfmt: skip
(use
  :wbthomason/packer.nvim {}

  :Olical/aniseed {}
  :Olical/conjure {}

  :nvim-lua/popup.nvim {}
  :nvim-lua/plenary.nvim {}

  :folke/lsp-trouble.nvim {:mod :trouble}
  :nvim-telescope/telescope.nvim {:mod :telescope}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}

  :folke/which-key.nvim {:mod :which-key}
  :akinsho/nvim-toggleterm.lua {:mod :toggleterm}
  :kabouzeid/nvim-lspinstall {:mod :lsp}
  :hrsh7th/nvim-compe {:mod :compe}
  :windwp/nvim-ts-autotag {:mod :autotag}
  :mhartington/formatter.nvim {:mod :formatter}
  :terrortylor/nvim-comment {:mod :comment}
  :hoob3rt/lualine.nvim {:mod :lualine}

  :tami5/compe-conjure {}
  :kyazdani42/nvim-web-devicons {}
  :neovim/nvim-lspconfig {}
  :glepnir/lspsaga.nvim {}
  :jose-elias-alvarez/nvim-lsp-ts-utils {}
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :danielpieper/telescope-tmuxinator.nvim {}
  :nvim-treesitter/nvim-treesitter {}
  :editorconfig/editorconfig-vim {}
  ; :kevinhwang91/nvim-bqf {}
  :bkad/CamelCaseMotion {}
  :glepnir/indent-guides.nvim {}
  :hrsh7th/vim-vsnip {}
  :rafamadriz/friendly-snippets {}
  :mlaursen/vim-react-snippets {}
  :folke/tokyonight.nvim {}
  :romainl/vim-cool {}
  :christoomey/vim-tmux-navigator {}
  :matze/vim-move {}
  :tpope/vim-repeat {}
  :tpope/vim-obsession {}
  :tpope/vim-vinegar {}
  :tpope/vim-unimpaired {}
  :NTBBloodbath/rest.nvim {})
