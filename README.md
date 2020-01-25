# Dotfiles

macOS environment managed by git and GNU Stow.

![img](assets/screenshot.png)

## Overview

- [Homebrew Defaults](extra/homebrew/Brewfile)
- [NeoVim Config](files/.config/nvim/init.vim)
- [Tmux Config](files/.tmux.conf)
- [Kitty.app Config](files/.config/kitty/kitty.conf)
- [Bash Runcom](files/.bashrc)
- [Bash Profile](files/.bash_profile)
- [yabai Config](files/.config/yabai/yabairc)
- [skhd Config](files/.config/skhd/skhdrc)
- [macOS Defaults](scripts/macos)

## Usage

There are two general approaches you can take to using these dotfiles:

1. Clone or git submodule and symlink what you want (recommended)
2. Use the installer (not recommended)

I don't recommend others to use the installer as it is preferable to curate your own environment according to your
needs and preferences. It's unlikely you need the precise set of tools that I do, and that you want to have them
configured in the same manner I do, however there is likely to be content in here you find useful.

```
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Clone repo
git clone git@github.com:camspiers/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

make all
make install
```


