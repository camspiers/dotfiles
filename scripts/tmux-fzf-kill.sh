#!/usr/bin/env bash

###############################################################
# Tmux FZF Kill
###############################################################

SELECTED_SESSIONS=$(tmux list-sessions -F "#S" | fzf -m --prompt="Kill: ")

if [ -n "$SELECTED_SESSIONS" ]; then
  # Set the IFS to \n to iterate over \n delimited sessions
  IFS=$'\n'
  for SESSION in $SELECTED_SESSIONS; do
    tmux kill-session -t "$SESSION"
  done
fi
