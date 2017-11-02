#!/bin/bash
# commandline tools
xcode-select --install
# brew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# oh-my-zsh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# personal settings
git clone https://github.com/jerrythomas/personalize.git
cd personalize

# zsh theme
cp themes/clarity.zsh-themes ~/.oh-my-zsh/themes/.
mv ~/.zshrc ~/.zshrc.old
sed 's/robbyrussel/clarity/' ~/.zshrc.old > ~/.zshrc

# terminal colors
# 

# Fonts
brew tap caskroom/fonts 
brew cask install font-fira-code

# Brew apps
brew.zsh
# Node libraries
node.zsh
# Python3

# vscode
# hendrixer's custom css into ~/.vcode/custom folder
cp themes/vscode.json ~/Library/Application\ Support/Code/User/settings.json