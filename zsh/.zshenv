if [[ "$OSTYPE" == darwin* ]]; then
  export DOTFILES_ZSH_PLATFORM="darwin"
elif [[ "$OSTYPE" == linux* ]]; then
  export DOTFILES_ZSH_PLATFORM="linux"
else
  export DOTFILES_ZSH_PLATFORM="unknown"
fi

export DOTFILES_ZSH_IS_WSL=0
if [[ "$DOTFILES_ZSH_PLATFORM" == "linux" ]] && [[ -n "${WSL_INTEROP:-}" || -n "${WSL_DISTRO_NAME:-}" ]]; then
  export DOTFILES_ZSH_IS_WSL=1
fi

typeset -U path PATH

if (( DOTFILES_ZSH_IS_WSL )); then
  source "$HOME/.zsh/env.wsl.zsh"
fi

source "$HOME/.zsh/env.shared.zsh"

case "$DOTFILES_ZSH_PLATFORM" in
  darwin)
    source "$HOME/.zsh/env.darwin.zsh"
    ;;
  linux)
    source "$HOME/.zsh/env.linux.zsh"
    ;;
esac
