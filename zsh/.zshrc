# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  macos
  colorize
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# altering path
# cargo/rust stuff
path+=$HOME/.cargo/bin 

# go & gopath 
export GOPATH=$HOME/go
path+="$GOPATH/bin"

# bun
path+="$HOME/.bun/bin"

# .local
path+="$HOME/.local/bin"

# opencode
path+=$HOME/.opencode/bin

# setting aliases
alias cat="bat"
alias ts="tmux-sessionizer"
alias lg="lazygit"
alias v="nvim ."
alias ls="eza"
alias la="ls -la"
alias lt='ls -la -T -L 2'
alias lt3='ls -la -T -L 3'
alias ltn='ls -la -T -L'

# load pyenv
eval "$(pyenv init --path)"

# load nvm
export NVM_DIR="$HOME/.nvm"
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@" # loads nvm upon use
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias pop to use env var and op
alias pop="ACCOUNT=\"Google Felippe\" op run --no-masking --env-file \"$HOME/.pop/.env\" -- pop"

# add zoxide
eval "$(zoxide init zsh --cmd cd)"
 
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# # Add completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then fpath+="$HOME/.zsh/completions"; fi

# fzf theme
export FZF_DEFAULT_OPTS='
  --color=bg+:#292e42,pointer:#fbcddd,fg:#c0caf5,info:#c0caf5,hl+:#5af78e,hl:#5af78e,gutter:#1f2335,prompt:#5af78e,border:#c0caf5
'
# lazy git config
export XDG_CONFIG_HOME="$HOME/.config"

# # Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit

# change theme
autoload -U promptinit; promptinit
prompt pure

# system information
fastfetch

# load tmux-sessionizer
bindkey -s ^g "ts\n"

# check if system is linux or macos
if [[ "$(uname)" == "Darwin" ]]; then # macOS
  # load keychain for macos
  ssh-add --apple-load-keychain -q

elif [[ "$(uname)" == "Linux" ]]; then # Linux
  # load keychain if installed
  if (( $+commands[keychain] )); then
    local keys=(
      $HOME/.ssh/id_ed25519
      $HOME/.ssh/id_rsa
    )

    # Filter out keys that don't exist
    local existing_keys=()
    for key in "${keys[@]}"; do
      if [[ -a "$key" ]]; then
        existing_keys+=("$key")
      fi
    done

    if (( ${#existing_keys[@]} > 0 )); then
      eval `keychain --quiet --eval --agents ssh "${existing_keys[@]}"`
    fi
  fi
fi

