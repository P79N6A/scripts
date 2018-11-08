
# variables
export EDITOR=vi
export SCRIPTS_DIR=$HOME/code/github.com/sorrycc/scripts
export CURRENT_DIR=$SCRIPTS_DIR/dotfiles
export HISTFILESIZE=1000000000
export HISTSIZE=1000000

# alias

## umi
alias ud="DEBUG=umi*,af-webpack* BROWSER=none HARD_SOURCE=1 umi dev"
alias udd="BROWSER=none HARD_SOURCE=1 umi dev"

## git
alias git=hub
alias gp="git push origin master"
alias gt="git status -sb"
alias gcr="git checkout master && git fetch && git rebase -i"
alias gclean="git reset --hard && git clean -df"
alias grebase="git fetch && git rebase -i"

function gacp() {
  git add ./ && git commit -am "update" && gp
}

## cd
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ~="cd ~"
alias -- -="cd -"
alias ll='ls -alhG'
alias ls='ls -G'

## npm & tnpm
alias ss="npm start"
alias dev="npm run dev"
alias build="npm run build"
alias bw="npm run build -- -w"
alias dw="npm run debug -- -w"
alias tnpmi="npm install tnpm@4 -g --registry=http://registry.npm.alibaba-inc.com"

## misc
alias h='history'
alias du='du -kh'
alias df='df -kh'
alias mkdir='mkdir -p'
alias 755='chmod 755'
alias 777='chmod 777'
alias cdtmp='cd `mktemp -d /tmp/sorrycc-XXXXXX`'
alias ag2="ag --ignore-dir dist --ignore-dir spm_modules --ignore-dir node_modules"
alias path='echo -e ${PATH//:/\\n}'
alias flush="dscacheutil -flushcache"
alias pi="ping www.baidu.com"
alias ip="ipconfig getifaddr en0 && ipconfig getifaddr en1"
alias qr='qrcode-terminal'
alias ee="stree"
alias ws="wstorm"

## system
alias showFiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hideFiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# functions
function nw() {
  node $SCRIPTS_DIR/network $1
}
function frm() {
  find . -type f -name "$@" -ls -delete
}
function bypass() {
  vi $CURRENT_DIR/bypass
  nw --bypass
}
function t() {
  # Defaults to 3 levels deep, do more with `t 5` or `t 1`
  # pass additional args after
  tree -I '.idea|.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -aC $2
}
function killport() {
  lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill
}
function bashrc() {
  vi $CURRENT_DIR/.bash_profile
  exec $SHELL -l
}
function mcd {
  mkdir $1 && cd $1;
}
function hosts {
  vi /etc/hosts
  #sudo rm -rf /etc/hosts.ac
}
function pfd() {
  osascript 2> /dev/null <<EOF
  tell application "Finder"
    return POSIX path of (target of window 1 as alias)
  end tell
EOF
}
function cdf() {
  cd "$(pfd)"
}
function gitlabconfig() {
  git config user.name "云谦"
  git config user.email "yunqian@alibaba-inc.com"
}

# lerna-changelog
# GH_TOKEN="523236d890ea33de3410b484fa8e613f139bfe6a"
export GITHUB_AUTH="aad8b481df374d6c131851309f726e63000aa6dc"

# extra
source $CURRENT_DIR/.setup

# backup
#source "`brew --prefix`/etc/grc.bashrc"
#alias mc="java -d64 -jar /Applications/Minecraft.app/Contents/Resources/Java/Bootstrap.jar"
#alias mc2="java -d64 -Xms2048M -Xmx2048M -jar /Applications/Minecraft.app/Contents/Resources/Java/Bootstrap.jar"
#export NODE_PATH=/usr/local/lib/node_modules
setopt interactivecomments
