export ZSH=$HOME/.oh-my-zsh
export SCRIPTS_DIR=$HOME/code/github.com/sorrycc/scripts

ZSH_THEME="robbyrussell"
plugins=(
  git
  autojump
  brew
  git
  git-extras
  git-flow
  git-prompt
  git-remote-branch
  github
  gitignore
  history
  history-substring-search
  iterm2
  node
  npm
  npx
  nvm
  tig
  vscode
  yarn
)
source $SCRIPTS_DIR/dotfiles/.bash_profile
source $ZSH/oh-my-zsh.sh
