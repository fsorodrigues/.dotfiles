if ! (( $+commands[go] )) && [[ -x "/usr/local/go/bin/go" ]]; then
  path+=("/usr/local/go/bin")
fi
