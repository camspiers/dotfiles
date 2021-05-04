(module dotfiles.plugins
        {autoload {nvim aniseed.nvim
                   core aniseed.core
                   packer packer
                   which-key which-key
                   trouble trouble
                   nvim-ts-autotag nvim-ts-autotag
                   toggleterm toggleterm
                   gitsigns gitsigns
                   nvim-comment nvim_comment}
         require-macros [dotfiles.macros]})

;; Curtesy of Olical
(defn safe-require-plugin-config [name]
      (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
        (when (not ok?)
          (print (.. "dotfiles error: " val-or-err)))))

;; Curtesy of Olical
(defn- use [...] "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
       (let [pkgs [...]]
         (packer.startup (fn [use]
                           (for [i 1 (core.count pkgs) 2]
                             (let [name (. pkgs i)
                                   opts (. pkgs (+ i 1))]
                               (-?> (. opts :mod) (safe-require-plugin-config))
                               (use (core.assoc opts 1 name))))))))

;; fnlfmt: skip
(use
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}
  :Olical/conjure {}
  :tami5/compe-conjure {}
  :nvim-lua/plenary.nvim {}
  :kyazdani42/nvim-web-devicons {}
  :folke/which-key.nvim {}
  :akinsho/nvim-toggleterm.lua {}
  :neovim/nvim-lspconfig {}
  :kabouzeid/nvim-lspinstall {:mod :lsp}
  :glepnir/lspsaga.nvim {}
  :hrsh7th/nvim-compe {:mod :compe}
  :windwp/nvim-ts-autotag {}
  :jose-elias-alvarez/nvim-lsp-ts-utils {}
  :folke/lsp-trouble.nvim {:requires ["kyazdani42/nvim-web-devicons"]}
  :nvim-telescope/telescope.nvim {:mod :telescope :requires ["nvim-lua/popup.nvim" "nvim-lua/plenary.nvim"]}
  :nvim-telescope/telescope-fzf-native.nvim {:run "make"}
  :danielpieper/telescope-tmuxinator.nvim {}
  :nvim-treesitter/nvim-treesitter {}
  :mhartington/formatter.nvim {:mod :formatter}
  :editorconfig/editorconfig-vim {}
  :terrortylor/nvim-comment {}
  :kevinhwang91/nvim-bqf {}
  :bkad/CamelCaseMotion {}
  :hoob3rt/lualine.nvim {:mod :lualine}
  :lewis6991/gitsigns.nvim {:requires ["nvim-lua/plenary.nvim"]}
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
  :tpope/vim-vinegar {})

(nvim-ts-autotag.setup)
(toggleterm.setup {})
(gitsigns.setup)
(nvim-comment.setup {:create_mappings false})
(which-key.setup {:window {:border :single} :layout {:height {:min 100}}})
(trouble.setup {})

