#!/bin/bash
# commandline tools
xcode-select --install
# prezsto
#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# personal settings
git clone https://github.com/jerrythomas/personalize.git
cd personalize

# zsh theme
cp themes/clarity.zsh-themes ~/.oh-my-zsh/themes/.
mv ~/.zshrc ~/.zshrc.old
sed 's/robbyrussel/clarity/' ~/.zshrc.old > ~/.zshrc

# terminal colors
cp themes/template.vimrc ~/.vimrc

# Fonts
brew tap caskroom/fonts
brew cask install font-fira-code

# Cursive font Script 12 BT
wget https://www.wfonts.com/download/data/2016/07/14/script12-bt/script12-bt.zip
unzip script12-bt.zip
sudo mv script12-bt/*.ttf ~/Library/Fonts
rm -rf script12-bt script12-bt.zip

# Brew apps
brew.zsh
# Node libraries
node.zsh
# Python3

cp themes/styles.less ~/.atom/
