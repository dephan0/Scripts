#!/bin/sh
# My standard 3-window tmux setup

tmux new-session -d -s main

# Send enter to close the message from .tmux.conf
tmux send-keys -t main:1 ENTER

# window no. 1 - ranger
tmux rename-window -t main:1 'ranger'
tmux send-keys -t main:1 'ranger' ENTER

# window no. 2 - shell
tmux new-window -t main:2 -n "${SHELL##*/}"

# window no. 3 - shell
tmux new-window -t main:3 -n "${SHELL##*/}"


tmux select-window -t main:1  # select ranger
tmux attach-session -t main
