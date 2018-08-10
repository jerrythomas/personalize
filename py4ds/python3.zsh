#!/bin/zsh
brew bundle install
loc=`pwd`
if (( $+commands[pip3] )); then
   pip3 install pipenv
   pip3 install PyScaffold
   pip3 install cookiecutter
fi
