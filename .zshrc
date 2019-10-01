# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

source "${HOME}/.zgen/zgen.zsh"

export PATH="/usr/local/bin/vim:$PATH"

if ! zgen saved; then
	zgen oh-my-zsh
  zgen oh-my-zsh plugins/ssh-agent
  zgen oh-my-zsh plugins/git

	#zgen load mafredri/zsh-async
	#zgen load marszall87/lambda-pure
  zgen load denysdovhan/spaceship-prompt spaceship

	zgen load chrissicool/zsh-256color
	zgen load djui/alias-tips
	zgen load RobSis/zsh-completion-generator
	zgen load supercrabtree/k
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load zsh-users/zsh-completions
	zgen load felixgravila/zsh-abbr-path
  zgen load lukechilds/zsh-better-npm-completion

	zgen save
fi

# Spaceship prompt
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  git
  package
  node
  line_sep
  exec_time
  exit_code
  char
)

# Vim Stuff
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh"


# Aliases
alias root='cd $(git rev-parse --show-toplevel)'
alias vip='vi $(git root)/package.json'
alias vi='nvim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
iterm2_print_user_vars() {
  iterm2_set_user_var gitName $(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)
}

# thefuck
eval $(thefuck --alias pls)

# dotfiles config
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Local configs
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
