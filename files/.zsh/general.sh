alias ll="ls -Glahs"
alias psgrep="ps aux | grep -v grep | grep"
alias ri="ri -f ansi"
alias reload="source ~/.zshrc"
alias pcat="pygmentize -f terminal256 -O style=tango -g"
alias hex="openssl rand -hex"

export INSTALL_DIR=$HOME/local
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export EDITOR=vim
export VISUAL=vim
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDPATH=.:/vagrant:/Projects:$HOME:$HOME/Projects
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export SAVEHIST=1000000
export GEM_HOME=$INSTALL_DIR/ruby/gems
export GEM_PATH=$INSTALL_DIR/ruby/gems
export NPM_HOME=$INSTALL_DIR/node/npm
export PATH="./node_modules/.bin:./bin:$GEM_HOME/bin:$NPM_HOME/bin:$HOME/local/bin:$HOME/.bash/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export CDHISTORY="/tmp/cd-$USER"
export PAGER="less"
export LESS="-REX"
export LESS_TERMCAP_mb=$'\E[04;33m'
export LESS_TERMCAP_md=$'\E[04;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

set -o ignoreeof
set bell-style none
ulimit -S -c 0

WORDCHARS=${WORDCHARS//[&=\/;\!#%\{]}
