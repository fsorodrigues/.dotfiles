export EDITOR="nvim"
export GOPATH="$HOME/go"
export XDG_CONFIG_HOME="$HOME/.config"
export PYENV_ROOT="$HOME/.pyenv"
export PNPM_HOME="$HOME/.local/share/pnpm"

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

for dbt_ls_root in "$HOME/personal/dbt-ls" "$HOME/projects/dbt-ls" "$HOME/Documents/projects/dbt-ls"; do
  if [[ -x "$dbt_ls_root/bin/dbt-ls" ]]; then
    export DBT_LS_ROOT="$dbt_ls_root"
    path+=("$DBT_LS_ROOT/bin")
    break
  fi
done
