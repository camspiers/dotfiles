################################################################################
# Bash Profile Configuration (Cam Spiers) ######################################
################################################################################

# Source bashrc
source "$HOME/.bashrc"

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

# Theme for fzf
export FZF_DEFAULT_OPTS='
--color fg:#aeadaf
--color bg:#232323
--color fg+:#232323
--color bg+:#aeadaf
--color hl:#d2813d
--color hl+:#8c9e3d
--color pointer:#d2813d
--color info:#b58d88
--color spinner:#949d9f
--color header:#949d9f
--color prompt:#6e9cb0
--color marker:#d2813d
'

export TMUX_1PASSWORD_OP_ITEMS_JQ_FILTER="
.[]
| [select(.overview.URLs | map(select(.u)) | length == 1)?]
| map([ .overview.title, .uuid ]
| join(\",\"))
| .[]
"

export BAT_THEME="Dracula"

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

# rbenv
eval "$(rbenv init -)"

# Fast Node Manager
eval "$(fnm env --multi)"

