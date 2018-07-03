#!/bin/zsh
# dependencies for bookdown

brew bundle install

virtualenv -p python3 $HOME/Applications/r4ds-py3
source $HOME/Applications/r4ds-py3/bin/activate
