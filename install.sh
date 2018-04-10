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
#git clone https://github.com/jerrythomas/personalize.git
#cd personalize

# zsh theme
pwd

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi
cp themes/template.vimrc ~/.vimrc

if [ ! -d ~/.atom ]; then
  mkdir -p ~/.atom
fi

cp themes/clarity.zsh-themes ~/.oh-my-zsh/themes/.
if [ -f ~/.atom/styles.less ]; then
  mv ~/.atom/styles.less ~/.atom/styles.old
fi
cp themes/styles.less ~/.atom

if [ -f ~/.zshrc ]; then
   mv ~/.zshrc ~/.zshrc.old
fi
sed 's/robbyrussel/clarity/' ~/.zshrc.old > ~/.zshrc

# terminal colors

# Fonts
brew tap caskroom/fonts
brew cask install font-fira-code

# Cursive font Script 12 BT
brew cask install ./font-script12-bt.rb

chmod 700 brew.zsh
chmod 700 node.zsh
# Brew apps
./brew.zsh
# Node libraries
./node.zsh
# Python3
