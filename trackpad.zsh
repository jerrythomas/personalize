#!/bin/zsh

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

