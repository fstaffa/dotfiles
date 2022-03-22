#!/usr/bin/env bash

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$ZDOTDIR/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$ZDOTDIR/fzf/keybindings.zsh"
