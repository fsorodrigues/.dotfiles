# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/fsorodrigues/.oh-my-zsh"

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
  #zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# altering path
path+=('/home/fsorodrigues/.cargo/bin')
path+=('/home/fsorodrigues/.local/bin')
path+=('/home/fsorodrigues/.local/share') 
path+=('/usr/local/go/bin')

# setting aliases
# alias color outputs
# alias cat="pygmentize -g"
alias nvim="/opt/nvim-linux64/bin/nvim"
alias vim="/opt/nvim-linux64/bin/nvim"
alias ls="exa"
alias la="ls -la"
alias lt='ls -la -T -L 2'
alias cat="/usr/bin/bat"
# load pyenv
# echo 'export PYENV_ROOT="$HOME/.pyenv"' 
# echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' 
# eval "$(pyenv init --path)"

# load nvm
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@" # loads nvm upon use
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# change theme
fpath+=('/home/fsorodrigues/.zsh/pure')
autoload -U promptinit; promptinit
prompt pure

# add zoxide
eval "$(zoxide init zsh --cmd cd)"

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# add neofetch call to show ascii art & system info upon opening terminal
neofetch

