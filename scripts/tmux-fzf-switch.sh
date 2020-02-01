#!/usr/bin/env bash

###############################################################
# Tmux FZF Switch
###############################################################

SESSION=$(tmux list-sessions -F "#S" | fzf --prompt="Switch: ")

if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION"
else
    tmux attach-session -t "$SESSION"
fi
