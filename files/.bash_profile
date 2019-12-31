# Source bashrc
source "$HOME/.bashrc"

# Joins paths together with whatever char is provided
function join_paths {
    local IFS="$1"; shift; echo "$*";
}

# Array for paths
PATHS=()

# Brew scripts
PATHS+=("/usr/local/bin:/usr/local/sbin")

# Python 3
PATHS+=("/usr/local/opt/python/libexec/bin")

# Fzf
PATHS+=("/usr/local/opt/fzf/bin")

# Global yarn scripts
PATHS+=($(yarn global bin))

# Coreutils
PATHS+=("/usr/local/opt/coreutils/libexec/gnubin")

# Personal scripts
PATHS+=("$HOME/.dotfiles/scripts")

# Global composer scripts
PATHS+=("$HOME/.composer/vendor/bin")

PATHS+=($(ruby -r rubygems -e 'puts Gem.user_dir')/bin)

PATH="$PATH:$(join_paths ":" "${PATHS[@]}")"

# Normalize the path and export it
eval $(/usr/libexec/path_helper -s)

# TODO, figure this out
export PATH="/usr/local/opt/ruby/bin:/usr/local/opt/python/libexec/bin:$PATH"

# Homebrew completions
source $(brew --prefix)/etc/bash_completion

# Fzf completions
source "/usr/local/opt/fzf/shell/completion.bash"

# Fzf key bindings
source "/usr/local/opt/fzf/shell/key-bindings.bash"

# macos now shows a deprecation warning about bash, remove it
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set editor
export EDITOR='nvim'

# Fast Node Manager
eval "$(fnm env --multi)"

