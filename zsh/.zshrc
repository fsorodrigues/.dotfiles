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
