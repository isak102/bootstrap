#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/.local/share/chezmoi"

printf "Input BECOME (sudo) password: "
read -s BECOME_PASS
printf "\nEnter VAULT password: "
read -s VAULT_PASS
printf "\n"

VAULT_PASS_FILE="/tmp/vaultpass"
BECOME_PASS_FILE="/tmp/becomepass"

# TODO: Remove files when script exits regardless of success or failure
echo "$VAULT_PASS" > $VAULT_PASS_FILE
echo "$BECOME_PASS" > $BECOME_PASS_FILE

ansible-playbook -i ./ansible/inventory -vv ./ansible/main.yml --vault-pass-file $VAULT_PASS_FILE --become-pass-file $BECOME_PASS_FILE

"$DOTFILES_DIR/setup/run.sh" --vault-pass-file "$VAULT_PASS_FILE" --become-pass-file "$BECOME_PASS_FILE"

rm -f $VAULT_PASS_FILE $BECOME_PASS_FILE
