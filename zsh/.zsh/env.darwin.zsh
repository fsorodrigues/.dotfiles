if ! (( $+commands[go] )); then
  for go_bin_dir in "/opt/homebrew/bin" "/usr/local/bin" "/usr/local/go/bin"; do
    if [[ -x "$go_bin_dir/go" ]]; then
      path+=("$go_bin_dir")
      break
    fi
  done
fi
