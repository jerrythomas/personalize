#!/bin/zsh

brew bundle install
open "Solarized Dark.terminal"
open "Dark Clarity.terminal"

osascript -e "tell application \"Terminal\" to set default settings to settings set \"Dark Clarity\""
#osascript -e "tell application \"Terminal\" to set the font name of window 1 to \"FuraCode Nerd Font\""
#osascript -e "tell application \"Terminal\" to set the font size of window 1 to 14"
