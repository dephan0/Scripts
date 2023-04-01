#!/bin/sh
# My standard tmux setup

tmux new-session -d -s main

# Send enter to close the message from .tmux.conf
tmux send-keys -t main:1 ENTER

# window no. 1 - ranger
tmux rename-window -t main:1 'ranger'
tmux send-keys -t main:1 'ranger' ENTER

# window no. 2 - bash
tmux new-window -t main:2 -n bash 'cd ~; bash -i'

# window no. 3 - bash
tmux new-window -t main:3 -n bash 'cd ~; bash -i'

tmux attach-session -t main
