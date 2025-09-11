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
path+=('$HOME/.cargo/bin')

# setting GOPATH
export GOPATH=$HOME/go
path+=("$GOPATH/bin")
# .local
path+="$HOME/.local/bin"

# setting aliases
# alias color outputs
alias cat="bat"
alias ts="tmux-sessionizer"

# load pyenv
eval "$(pyenv init --path)"

# load nvm
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@" # loads nvm upon use
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# load chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# change theme
autoload -U promptinit; promptinit
prompt pure

# alias pop to use env var and op
alias pop="ACCOUNT=\"Google Felippe\" op run --no-masking --env-file \"$HOME/.pop/.env\" -- pop"

# add zoxide
eval "$(zoxide init zsh --cmd cd)"
 
# altering path for bun 
path+="$HOME/.bun/bin"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
. "/Users/fsorodrigues/.deno/env"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/fsorodrigues/.zsh/completions:"* ]]; then export FPATH="/Users/fsorodrigues/.zsh/completions:$FPATH"; fi

# Initialize zsh completions (added by deno install script)
# fzf theme
export FZF_DEFAULT_OPTS='
  --color=bg+:#292e42,pointer:#fbcddd,fg:#c0caf5,info:#c0caf5,hl+:#5af78e,hl:#5af78e,gutter:#1f2335,prompt:#5af78e,border:#c0caf5
'

autoload -Uz compinit
compinit

# opencode
export PATH=/Users/fsorodrigues/.opencode/bin:$PATH

# system information
fastfetch

# load tmux-sessionizer
bindkey -s ^f "ts\n"

