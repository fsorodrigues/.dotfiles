export EDITOR="nvim"
export GOPATH="$HOME/go"
export XDG_CONFIG_HOME="$HOME/.config"
export PYENV_ROOT="$HOME/.pyenv"
export PNPM_HOME="$HOME/.local/share/pnpm"
export NVM_DIR="$HOME/.nvm"

path+=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$GOPATH/bin"
  "$HOME/.opencode/bin"
)

if [[ -d "$HOME/.bun/bin" ]]; then
  path+=("$HOME/.bun/bin")
fi

if [[ -d "$HOME/neovim/bin" ]]; then
  path+=("$HOME/neovim/bin")
fi

if [[ -d "$PNPM_HOME" ]]; then
  path+=("$PNPM_HOME")
fi

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  nvm use --silent default >/dev/null
fi

export DBT_LS_DIR="${DBT_LS_DIR:-$HOME/personal/dbt-ls}"
