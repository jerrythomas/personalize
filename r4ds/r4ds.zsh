#!/bin/zsh
brew bundle install

virtualenv -p python3 $HOME/Applications/r4ds-py3
source $HOME/Applications/r4ds-py3/bin/activate

. ../py4ds/opencv.zsh -e r4ds-py3
