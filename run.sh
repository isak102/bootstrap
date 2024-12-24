#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/.local/share/chezmoi"

ansible-playbook -i ./ansible/inventory -vv --ask-vault-pass ./ansible/main.yml

"$DOTFILES_DIR/setup/run.sh"
