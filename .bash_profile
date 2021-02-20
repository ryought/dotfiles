#
# .bash_profile
#

# bash-completion
# if [ -f /usr/local/etc/bash_completion ]; then
#   . /usr/local/etc/bash_completion
#   . /usr/local/etc/bash_completion.d/git-completion.bash
#   source /usr/local/etc/bash_completion.d/git-prompt.sh
#   source <(npm completion)
# fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[ -f /usr/local/anaconda3/etc/profile.d/conda.sh ] && . /usr/local/anaconda3/etc/profile.d/conda.sh

# load .inputrc
[ -f ~/.inputrc ] && bind -f ~/.inputrc

## load .bashrc ##
test -r ~/.bashrc && source ~/.bashrc
