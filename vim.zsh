#!/bin/zsh 
git clone https://github.com/altercation/vim-colors-solarized.git
mkdir -p ~/.vim/colors/
mv vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
rm -rf vim-colors-solarized

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi
cp themes/template.vimrc ~/.vimrc

