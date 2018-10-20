#!/bin/bash
set -Ceu

echo "Homebrew & commandline tools"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Enter押す
brew update
brew upgrade
brew tap caskroom/cask  # homebrew cask

echo "git"
brew install git wget curl the_silver_searcher readline jq colordiff watchman
git --version

echo "bash"
brew install bash bash-completion z
sudo -S -- sh -c 'echo '/usr/local/bin/bash' >> /etc/shells'
chsh -s /usr/local/bin/bash     # defaultize
brew install direnv

# tmux
brew install tmux reattach-to-user-namespace

# editor
brew install vim --with-override-system-vi
# plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# other languages
brew install go lame lua mercurial node phantomjs

# quick look plugins
brew cask install qlstephen qlmarkdown

echo "fonts"
echo "open http://mix-mplus-ipa.osdn.jp/migu/ download migu 2M and install"
brew tap cask/fonts
brew cask install font-migu-2m
brew cask install font-sourcecode-pro

echo "must apps"
# スキームの設定 右端に寄せる
brew cask install google-chrome # ブラウザ
# ログイン 同期の設定 ホームの設定
brew cask install virtualbox # 仮想化
# VMの移動

echo "Xcode"
brew install mas
mas install 497799835  # Xcode (8.2.1)


# 必須
brew cask install \
  google-chrome google-drive-file-stream virtualbox slack alfred dropbox gimp appcleaner bettertouchtool
  hyperswitch aquaterm skype mactex skim spotify vlc vscode pandoc xquartz visual-studio-code vagrant docker
# option
brew cask install anaconda haskell-for-mac blender pdfsam-basic fiji firefox the-unarchiver

# app store
mas install 539883307 # line
mas install 417375580 # BetterSnapTool
mas install 692867256 # Simplenote
mas install 868968810 # fusion 360

# tex
# ヒラギノ埋め込み
sudo cjk-gs-integrate --link-texmf --force
sudo mktexlsr
sudo kanji-config-updmap-sys hiragino-elcapitan-pron
# gui起動して、設定プロファイルuptex(ptex2pdf)を選択

# 123D Design
# autodesk fusion
# arduino

### shareware
bettertouch #file
office #id
webstorm #id
alfred #key

# set up shellscript for macos
echo "update homebrew"
brew update

echo "create working directory"
mkdir ~/src

echo "C"
brew install gcc gdb
open -a "Keychain Access.app"
echo "証明書を作成: http://qiita.com/kaityo256/items/d2f7ac7acc42cf2098b2"
sudo codesign -s gdb-cert /usr/local/bin/gdb
echo "再起動"

echo "python"
pyenv install anaconda2-4.4.0
pyenv install anaconda3-4.4.0
pyenv versions
pyenv global anaconda3-4.4.0
pyenv rehash

brew cask install pycharm sage
pip install -U pytest

echo "useful tools"
brew install noti # command notifier
brew install cmake

echo "middleman"
gem install middleman
# middleman site dir で middleman build / deployを実行

echo "go"
brew install go
# 環境変数の設定 GOPATHのexportだけ
# デバッガ
echo "まず証明書をdlv-certで作って"
brew install go-delve/delve/delve

echo "scheme"
brew install guile

echo "node.js"
brew install node
brew cask install webstorm
# plugin: Ideavimを追加
brew install yarn --without-node

echo "aws"
sudo pip install awscli

echo "firebase"
npm -g install firebase-tools

echo "docker"
brew cask install docker
open /Applications/Docker.app
echo "set up in GUI"
read ans
docker --version

echo "vagrant"
brew cask install vagrant


echo "android"
brew cask install android-studio

echo "haskell"
brew cask install haskell-for-mac
