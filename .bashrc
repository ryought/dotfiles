#
# .bashrc
#

## bash option ##
shopt -s autocd
shopt -s cdspell  # fix typo automatically when directory moving
shopt -s nocaseglob
shopt -s dirspell
shopt -s globstar  # enable "**"

# C-d
export IGNOREEOF=1  # disable C-d for exiting bash

# C-s, C-q
if [[ -t 0 ]]; then
  stty stop undef  # disable C-s
  stty start undef  # disable C-q
fi

## history ##
# sync history with multiple session
# http://iandeth.dyndns.org/mt/ian/archives/000651.html
shopt -u histappend
export PROMPT_COMMAND="history -a; history -c; history -r;"
export HISTCONTROL=erasedups:ignoreboth
export HISTSIZE=1000000
export HISTIGNORE="history*:fg*:bg*:vi"

## completion / plugin ##
# z - cd fast with history
[ -f /usr/local/etc/profile.d/z.sh ] && . /usr/local/etc/profile.d/z.sh
# fzf - fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# serverless - AWS lambda
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

## direnv ##
if type "direnv" > /dev/null 2>&1
then
  eval "$(direnv hook bash)"
fi

## prompt ##
# show git branches
if type __git_ps1 > /dev/null 2>&1 ; then
  GIT_PS1_SHOWDIRTYSTATE=1  # unstaged:*  staged:+
  GIT_PS1_SHOWSTASHSTATE=1  # :$
  GIT_PS1_SHOWUNTRACKEDFILES=1  # :%
  GIT_PS1_SHOWUPSTREAM=
  GIT_PS1_SHOWCOLORHINTS=1
  git_prompt='$(__git_ps1)'
fi
# prompt definition
export PROMPT_DIRTRIM=3  # trim path longer than 3
if [[ "${SSH_TTY}" ]]; then
  # ssh
  PS1="\[\033[33m\](\t) \[\033[37m\033[41m\] \u@\h \[\033[00m\] \[\033[01m\]\w\[\033[31;2m\]${git_prompt}\[\033[00m\] \\$ "
elif [ $UID -eq 0 ]; then
  # root
  PS1='\[\033[31m\](\t)\u@\H\[\033[00m\] \[\033[01m\]\w \[\033[00m\]\\$ '
else
  # normal user
  PS1="\[\033[32m\](\t)\[\033[00m\] \[\033[01m\]\w\[\033[31;2m\]${git_prompt}\[\033[00m\] \\$ "
fi

## OS specific settings ##
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

## alias & custom commands ##
alias grep="grep --color"
alias o="open ."
alias vi="vim"
alias c="clang++ -std=c++14 -Wall -g -fsanitize=undefined -D_GLIBCXX_DEBUG"
alias g="git"
alias gti="git"
alias gt="git"
alias l="less"
alias L="less -S"
alias p="papier"
function fetchx () {
  command scp mlab.hx01:$1 $2
}
cd () {
  builtin cd "$@" && ls
}
back () {
  cd --
}

if type "colordiff" > /dev/null 2>&1
then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
alias less='less -R'

# parallel compression
if type "pigz" > /dev/null 2>&1
then
  alias gzip='pigz'
fi
if type "pbzip2" > /dev/null 2>&1
then
  alias bzip2='pbzip2'
fi

## editor ##
export EDITOR=vim
export LANG=ja_JP.UTF-8

## global PATH setting ##
# for my tools
export PATH="$PATH:$HOME/.tools:$HOME/.tools-private/bin"

## load other files ##
# .inputrc
[ -f ~/.inputrc ] && bind -f ~/.inputrc
# .bashrc_*: machine dependent settings
for file in ~/.bashrc_*;
do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    source $file
  fi
done
unset file

# nvm
export NVM_DIR="$HOME/.nvm"
# delay loading functions
function nvm () {
  if type 'nvm' > /dev/null 2>&1
  then
    echo 'loading nvm'
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi
  nvm $@
}
