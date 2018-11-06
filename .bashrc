#
# .bashrc
#

## bash option ##
shopt -s autocd
shopt -s cdspell  # directory移動時の小さなtypoを修正
shopt -s nocaseglob  # 「*」などのパス名展開で大文字小文字を区別しない
shopt -s dirspell
shopt -s globstar  # 「**」が使えるようになる

## completion / plugin ##
# z - cd fast with history
[ -f /usr/local/etc/profile.d/z.sh ] && . /usr/local/etc/profile.d/z.sh
# fzf - fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## command ##
if type "direnv" > /dev/null 2>&1
then
  eval "$(direnv hook bash)"
fi

## prompt ##
# show git branches
if type __git_ps1 > /dev/null 2>&1 ; then
  GIT_PS1_SHOWDIRTYSTATE=1  # unstagedがある*  stagedがある+
  GIT_PS1_SHOWSTASHSTATE=1  # stashに何か入っている $
  GIT_PS1_SHOWUNTRACKEDFILES=1  # untrackedファイルがある %
  GIT_PS1_SHOWUPSTREAM=  # upstreamより遅れているか
  GIT_PS1_SHOWCOLORHINTS=1
  git_prompt='$(__git_ps1)'
fi
# prompt definition
export PROMPT_DIRTRIM=3  # trim path longer than 3
if [ -n "$SSH_CLIENT" ]; then
  # ssh
  PS1="\[\033[33m\](\t) \[\033[37m\033[41m\] \u@\h \[\033[00m\] \[\033[01m\]\w\[\033[31;2m\]${git_prompt}\[\033[00m\] \\$ "
elif [ $UID -eq 0 ]; then
  # root
  PS1='\[\033[31m\](\t)\u@\H\[\033[00m\] \[\033[01m\]\w \[\033[00m\]\\$ '
else
  # normal user
  PS1="\[\033[32m\](\t)\[\033[00m\] \[\033[01m\]\w\[\033[31;2m\]${git_prompt}\[\033[00m\] \\$ "
fi

if [ "$(uname)" = 'Darwin' ]; then
  # macos
  export LSCOLORS=gxfxcxdxbxegedabagacad
  alias ls="ls -FG"
  alias la="ls -lahFG"
else
  # linux
  # export LS_COLORS="no=00:fi=00:di=01;36:ln=01;34"
  alias ls='ls --color=auto'
  alias la="ls -la -h --color=auto"
fi

## history ##

# 複数プロセスでhistoryファイルの共有
# (bad)http://yuzugosho.blog.fc2.com/blog-entry-8.html
# (good)https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
shopt -s histappend
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
export HISTCONTROL=erasedups:ignoreboth  # 空白始まりと重複コマンドは記録しない
export HISTSIZE=1000000
export HISTIGNORE="history*:ls*:la*:fg*:bg*:vi"

# 終了時にhistoryファイルを共有するだけなら下
# shopt -s histappend

# TODO どこで使ったコマンドかを覚えておく

## alias ##
alias grep="grep --color"
alias o="open ."
alias vi="vim"
alias c="clang++ -std=c++14 -Wall -g -fsanitize=undefined -D_GLIBCXX_DEBUG"

cd () {
  # builtin cd -- "$@" && ls
  builtin cd "$@" && ls
}
back () {
  cd --
}

function cs() {
  \cd $1
  ls
}
alias cs=cs

if type "colordiff" > /dev/null 2>&1
then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

alias less='less -R'

## editor ##
export EDITOR=vim
export LANG=ja_JP.UTF-8

## .inputrc ##
[ -f ~/.inputrc ] && bind -f ~/.inputrc


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

# on hx cluster
if [ -d "/work/ryought/tools/anaconda3" ]; then
  __conda_setup="$(CONDA_REPORT_ERRORS=false '/work/ryought/tools/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
  if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
  else
    if [ -f "/work/ryought/tools/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/work/ryought/tools/anaconda3/etc/profile.d/conda.sh"
      CONDA_CHANGEPS1=false conda activate base
    else
      \export PATH="/work/ryought/tools/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup
fi
