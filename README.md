# Dotfiles - Cam Spiers

macOS environment managed by git and GNU Stow.

## Overview

The following are the major components of the dotfiles project.

- [Homebrew Defaults](extra/homebrew/Brewfile)
- [Neovim Config](files/.config/nvim/init.lua)
- [Tmux Config](files/.tmux.conf)
- [Kitty.app Config](files/.config/kitty/kitty.conf)
- [Bash Runcom](files/.bashrc)
- [Bash Profile](files/.bash_profile)
- [yabai Config](files/.config/yabai/yabairc)
- [skhd Config](files/.config/skhd/skhdrc)
- [macOS Defaults](scripts/macos)

## Usage

I don't really recommend others use the following installation method, instead
I encourage you to copy what you like manually and curate your own dotfiles,
project, but for those not of the faint of heart:

### Install Homebrew

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Clone repo

```
git clone git@github.com:camspiers/dotfiles.git ~/.dotfiles
```

### Install

```
cd ~/.dotfiles
make all
make install
```
