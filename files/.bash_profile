################################################################################
# Bash Profile Configuration (Cam Spiers) ######################################
################################################################################

# Source bashrc
source "$HOME/.bashrc"

# Source local bashrc
if [ -f "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi

################################################################################
# Exports ######################################################################
################################################################################

# Ensures that SHELL is set to my $PATH bash, especially for tmux
export SHELL=$(which bash)

# macOS now shows a deprecation warning about bash, remove it
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set editor
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
fi

alias nvim="nvim --listen /tmp/nvimsocket"

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
    export VISUAL="nvim"
    export EDITOR="nvim"
fi


# Include git information in FZF preview
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'
export FZF_PREVIEW_COMMAND='bat {}'
export FZF_DEFAULT_OPTS="
  --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
  --bind ctrl-a:select-all,ctrl-d:deselect-all,tab:toggle+up,shift-tab:toggle+down
"

export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rc

################################################################################
# Completions ##################################################################
################################################################################

# Homebrew completions
source $(brew --prefix)/etc/bash_completion

# Fzf completions
source "/usr/local/opt/fzf/shell/completion.bash"

# Fzf key bindings
source "/usr/local/opt/fzf/shell/key-bindings.bash"

################################################################################
# Environment Managers #########################################################
################################################################################

source <(kitty + complete setup bash)

# rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init - bash)"

# Fast Node Manager
eval "$(fnm env)"

alias luamake=/Users/camspiers/dev/lua-language-server/3rd/luamake/luamake
