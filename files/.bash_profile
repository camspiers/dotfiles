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
export EDITOR='nvim'

# Ruby
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

# Include git information in FZF preview
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --iglob "!.DS_Store" --iglob "!.git"'
export FZF_PREVIEW_COMMAND='bat {}'
export FZF_DEFAULT_OPTS="
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
  --bind ctrl-a:select-all,ctrl-d:deselect-all,tab:toggle+up,shift-tab:toggle+down
"

export TMUX_1PASSWORD_OP_ITEMS_JQ_FILTER="
.[]
| [select(.overview.URLs | map(select(.u)) | length == 1)?]
| map([ .overview.title, .uuid ]
| join(\",\"))
| .[]
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
eval "$(rbenv init -)"

# Fast Node Manager
eval "$(fnm env --multi)"

# Load nvm
export NVM_DIR="$HOME/.nvm"
 [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
 [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
