#!/bin/zsh
# Icon size of Dock items
defaults write com.apple.dock tilesize -int 46
# Lock the Dock size
defaults write com.apple.dock size-immutable -bool true
# Dock magnification
defaults write com.apple.dock magnification -bool false

# Icon size of magnified Dock items
defaults write com.apple.dock largesize -int 64
# Minimization effect: 'genie', 'scale', 'suck'
defaults write com.apple.dock mineffect -string 'scale'
# Prefer tabs when opening documents: 'always', 'fullscreen', 'manual'
defaults write NSGlobalDomain AppleWindowTabbingMode -string 'always'
# Dock orientation: 'left', 'bottom', 'right'
defaults write com.apple.dock 'orientation' -string 'right'
# Minimize to application
defaults write com.apple.dock minimize-to-application -bool true
# Animate opening applications
defaults write com.apple.dock launchanim -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Remove all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Atom.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

killall Dock
