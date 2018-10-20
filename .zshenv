export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

eval "$(pyenv init -)"

if which rbenv> /dev/null; then eval "$(rbenv init -)"; fi
