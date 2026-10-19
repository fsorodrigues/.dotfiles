export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  colorize
  zsh-syntax-highlighting
)

if [[ "${DOTFILES_ZSH_PLATFORM:-}" == "darwin" ]]; then
  plugins+=(macos)
fi

# Add local completion and prompt functions before Oh My Zsh runs compinit.
if [[ -d "$HOME/.zsh/completions" ]] && [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
  fpath+=("$HOME/.zsh/completions")
fi

if [[ -d "$HOME/.zsh/pure" ]] && [[ ":$FPATH:" != *":$HOME/.zsh/pure:"* ]]; then
  fpath+=("$HOME/.zsh/pure")
fi

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.zsh/rc.shared.zsh"

case "${DOTFILES_ZSH_PLATFORM:-}" in
  darwin)
    source "$HOME/.zsh/rc.darwin.zsh"
    ;;
  linux)
    source "$HOME/.zsh/rc.linux.zsh"

    if (( ${DOTFILES_ZSH_IS_WSL:-0} )); then
      source "$HOME/.zsh/rc.wsl.zsh"
    fi
    ;;
esac
