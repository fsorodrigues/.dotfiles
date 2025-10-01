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
  colorize
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# altering path
path+=($HOME/.local/bin)
path+=($HOME/neovim/bin)
fpath+=($HOME/.zsh/pure)
path+=/usr/local/go/bin
path+=($HOME/.cargo/bin)

# create vim binding mode for shell
bindkey -v

# setting aliases
alias cat="batcat"
alias v="nvim"
alias ts="tmux-sessionizer"
alias ls="eza"
alias tldr="tealdeer"
alias fd="fdfind"
alias la="ls -la"
alias lt='ls -la -T -L 2'
alias lt3='ls -la -T -L 3'
alias ltn='ls -la -T -L'

# load pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fzf theme
export FZF_DEFAULT_OPTS='
  --color=bg+:#292e42,pointer:#fbcddd,fg:#c0caf5,info:#c0caf5,hl+:#5af78e,hl:#5af78e,gutter:#1f2335,prompt:#5af78e,border:#c0caf5
'

# load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@" # loads nvm upon use

# change theme
autoload -U promptinit; promptinit
prompt pure

# add zoxide
eval "$(zoxide init zsh --cmd cd)"

# add keychain
eval `keychain -q --eval --agents ssh id_ed25519`
 
bindkey -s ^g "ts\n"

