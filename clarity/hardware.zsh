#!/bin/zsh

brew bundle install

## Configure trackpad.

# Enable tap to click. (Don't have to press down on the trackpad -- just tap it.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable "tap-and-a-half" to drag.
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1
#defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1

# Enable tap to click for the login screen. (May or may not work in Mavericks.)
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable 3-finger drag. (Moving with 3 fingers in any window "chrome" moves the window.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 2
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 2

defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton


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
