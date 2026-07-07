alias v="nvim"
alias ts="tmux-sessionizer"
alias lg="lazygit"
alias la="ls -la"
alias oc="opencode ."
alias pop="ACCOUNT=\"Google Felippe\" op run --no-masking --env-file \"$HOME/.pop/.env\" -- pop"

if (( $+commands[bat] )); then
  alias cat="bat"
elif (( $+commands[batcat] )); then
  alias cat="batcat"
fi

if (( $+commands[eza] )); then
  alias ls="eza"
  alias lt='ls -la -T -L 2'
  alias lt3='ls -la -T -L 3'
  alias ltn='ls -la -T -L'
fi

if ! (( $+commands[fd] )) && (( $+commands[fdfind] )); then
  alias fd="fdfind"
fi

bindkey -v

if [[ -d "$PYENV_ROOT/bin" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

export FZF_DEFAULT_OPTS='
  --color=bg+:#292e42,pointer:#fbcddd,fg:#c0caf5,info:#c0caf5,hl+:#5af78e,hl:#5af78e,gutter:#1f2335,prompt:#5af78e,border:#c0caf5
'

export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh"
fi

if [[ -s "$NVM_DIR/bash_completion" ]]; then
  . "$NVM_DIR/bash_completion"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

if [[ -s "$HOME/.bun/_bun" ]]; then
  source "$HOME/.bun/_bun"
fi

if [[ -d "$HOME/.zsh/completions" ]] && [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
  fpath+=("$HOME/.zsh/completions")
fi

if [[ -d "$HOME/.zsh/pure" ]] && [[ ":$FPATH:" != *":$HOME/.zsh/pure:"* ]]; then
  fpath+=("$HOME/.zsh/pure")
fi

autoload -Uz compinit
compinit

autoload -U promptinit
promptinit
prompt pure

bindkey -s '^g' 'ts\n'

_dotfiles_load_ssh_keys_keychain() {
  local key
  local -a existing_keys=()

  (( $+commands[keychain] )) || return 0

  for key in "$@"; do
    if [[ -f "$key" ]]; then
      existing_keys+=("$key")
    fi
  done

  (( ${#existing_keys[@]} > 0 )) || return 0

  eval "$(keychain --quiet --eval --agents ssh "${existing_keys[@]}")"
}

_dotfiles_load_ssh_keys_macos() {
  local key

  (( $+commands[ssh-add] )) || return 0

  for key in "$@"; do
    if [[ -f "$key" ]]; then
      ssh-add --apple-load-keychain -q "$key" >/dev/null 2>&1
    fi
  done
}
