#!/usr/bin/env bash

###############################################################
# Tmux FZF Switch
###############################################################

SESSION=$(tmux list-sessions -F "#S" | fzf --prompt="Session: ")

if [ -n "$TMUX" ]; then
    tmux switch-client -t "$SESSION"
else
    tmux attach-session -t "$SESSION"
fi
