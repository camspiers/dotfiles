local fn = vim.fn
local cmd = vim.cmd
local path = fn.stdpath('data') .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(path)) > 0 then
  cmd("!git clone https://github.com/wbthomason/packer.nvim " .. path)
  cmd "packadd packer.nvim"
end

require"packer".startup(function(use)
  use "wbthomason/packer.nvim"

  --  general deps
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "folke/which-key.nvim"
  use "akinsho/nvim-toggleterm.lua"

  -- lsp
  use "neovim/nvim-lspconfig"
  use "kabouzeid/nvim-lspinstall"
  use "glepnir/lspsaga.nvim"
  use "hrsh7th/nvim-compe"
  use "windwp/nvim-ts-autotag"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  -- search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use "danielpieper/telescope-tmuxinator.nvim"

  -- syntax
  use "sheerun/vim-polyglot"
  use "nvim-treesitter/nvim-treesitter"
  use "mhartington/formatter.nvim"
  use "editorconfig/editorconfig-vim"

  -- editor
  use "terrortylor/nvim-comment"
  use "kevinhwang91/nvim-bqf"
  use "bkad/CamelCaseMotion"

  -- visual
  use "hoob3rt/lualine.nvim"
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use "glepnir/indent-guides.nvim"

  -- snipets
  use "hrsh7th/vim-vsnip"
  use "rafamadriz/friendly-snippets"
  use "mlaursen/vim-react-snippets"

  -- themes
  use "ishan9299/modus-theme-vim"
  use 'folke/tokyonight.nvim'

  -- old
  use "romainl/vim-cool"
  use "christoomey/vim-tmux-navigator"
  use "matze/vim-move"

  -- basics
  use "wincent/terminus"
  use "tpope/vim-sensible"
  use "tpope/vim-repeat"
  use "tpope/vim-obsession"
  use "tpope/vim-vinegar"
end)

-- -- vim options
require 'options'

-- config plugins
require 'plugins'

-- -- vim mappings
require 'mappings'
