#!/usr/bin/env bash
# Choose a config file in fzf and edit it in EDITOR
set -eo pipefail

choice="$(find ~/dotfiles -not -path "*.git/*" -not -type d -print0 | fzf --read0)"
"$EDITOR" "$choice"
