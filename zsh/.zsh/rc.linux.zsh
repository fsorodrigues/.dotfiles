typeset -a SSH_KEYS
SSH_KEYS=(
)

if (( ! ${DOTFILES_ZSH_IS_WSL:-0} )) && (( ${#SSH_KEYS[@]} > 0 )); then
  _dotfiles_load_ssh_keys_keychain "${SSH_KEYS[@]}"
fi
