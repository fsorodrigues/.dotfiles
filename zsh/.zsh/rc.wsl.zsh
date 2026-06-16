if [[ -x "$HOME/.zsh/symlink_ssh.sh" ]]; then
  "$HOME/.zsh/symlink_ssh.sh"
fi

export NODE_OPTIONS="--use-openssl-ca"
RPROMPT="%F{cyan}%D{%T}"

typeset -a SSH_KEYS
SSH_KEYS=(
  "$HOME/.ssh/id_ed25519"
  "$HOME/.ssh/id_ed25519_gmail"
)

if (( ${#SSH_KEYS[@]} > 0 )); then
  _dotfiles_load_ssh_keys_keychain "${SSH_KEYS[@]}"
fi
