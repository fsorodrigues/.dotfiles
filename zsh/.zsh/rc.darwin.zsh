typeset -a SSH_KEYS
SSH_KEYS=(
)

if (( ${#SSH_KEYS[@]} > 0 )); then
  _dotfiles_load_ssh_keys_macos "${SSH_KEYS[@]}"
fi
