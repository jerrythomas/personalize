#!/bin/zsh

brew tap caskroom/fonts
brew cask install font-fira-code
brew cask install font-firacode-nerd-font

# Cursive font Script 12 BT
brew cask install ./font-script12-bt.rb
osascript -e "tell application \"Terminal\" to set default settings to settings set \"Dark Clarity\""
osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"FuraCode Nerd Font\""
osascript -e "tell application \"Terminal\" to set the font size of window 1 to 14"
