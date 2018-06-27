#!/bin/bash
# commandline tools

install_brew (){
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # Fonts
  brew tap caskroom/fonts
  brew cask install font-fira-code
  brew cask install font-firacode-nerd-font

  # Cursive font Script 12 BT
  brew cask install ./font-script12-bt.rb
}

install_brew

git clone https://github.com/altercation/vim-colors-solarized.git
mkdir -p ~/.vim/colors/
mv vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
rm -rf vim-colors-solarized

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi
cp themes/template.vimrc ~/.vimrc

if [ ! -d ~/.atom ]; then
  mkdir -p ~/.atom
fi

#cp themes/clarity.zsh-themes ~/.oh-my-zsh/themes/.
if [ -f ~/.atom/styles.less ]; then
  mv ~/.atom/styles.less ~/.atom/styles.old
fi
cp themes/styles.less ~/.atom

# terminal colors

#chmod 700 brew.zsh
#chmod 700 node.zsh
# Brew apps
#./brew.zsh
# Node libraries
#./node.zsh
# Python3
