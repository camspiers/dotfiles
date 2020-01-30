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

# Include git information in fzf preview
export FZF_PREVIEW_COMMAND='bat --style="changes" --color=always {}'

# Theme for fzf
# Base16 Chalk
# Author: Chris Kempson (http://chriskempson.com)

_gen_fzf_default_opts() {

local color00='#151515'
local color01='#202020'
local color02='#303030'
local color03='#505050'
local color04='#b0b0b0'
local color05='#d0d0d0'
local color06='#e0e0e0'
local color07='#f5f5f5'
local color08='#fb9fb1'
local color09='#eda987'
local color0A='#ddb26f'
local color0B='#acc267'
local color0C='#12cfc0'
local color0D='#6fc2ef'
local color0E='#e1a3ee'
local color0F='#deaf8f'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts

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

# rbenv
eval "$(rbenv init -)"

# Fast Node Manager
eval "$(fnm env --multi)"

