#!/bin/zsh

brew bundle install

open "Solarized Dark.terminal"
open "Dark Clarity.terminal"

osascript -e "tell application \"Terminal\" to set default settings to settings set \"Dark Clarity\""
#osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"FuraCode Nerd Font\""
#osascript -e "tell application \"Terminal\" to set the font size of window 1 to 14"

git clone https://github.com/altercation/vim-colors-solarized.git
mkdir -p ~/.vim/colors/
mv vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
rm -rf vim-colors-solarized

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi
cp template.vimrc ~/.vimrc

sudo ruby prezto.rb --global --prompt clarity
