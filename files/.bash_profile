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

# Nord Theme for fzf
export FZF_DEFAULT_OPTS='
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
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

