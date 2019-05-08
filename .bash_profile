#
# .bash_profile for local mac
#

# homebrew
if [ -d "/work/ryought/" ]; then
  export PATH=/work/ryought/tools/vim/bin:/work/ryought/tools/anaconda3/bin:$PATH:/usr/local/bin
else
  export PATH=/usr/local/anaconda3/bin:$PATH:/usr/local/bin
fi

# android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# golang
export GOPATH=$HOME/src/go
# mytools
export PATH=$PATH:$HOME/src/dotfiles-private/tools

#
# env
#

if command -v pyenv 1>/dev/null 2>&1;
then
  eval "$(pyenv init -)"
fi

# export PATH=$HOME/.rbenv/bin:$PATH


#
# bash-completion
# homebrew
#

# if [ -f /usr/local/etc/bash_completion ]; then
#   . /usr/local/etc/bash_completion
#   . /usr/local/etc/bash_completion.d/git-completion.bash
#   source /usr/local/etc/bash_completion.d/git-prompt.sh
#   source <(npm completion)
# fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/anaconda3/etc/profile.d/conda.sh ] && . /usr/local/anaconda3/etc/profile.d/conda.sh

#
# load .bashrc
#

test -r ~/.bashrc && source ~/.bashrc
