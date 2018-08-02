#!/bin/zsh
# check success of shell scripts.

# Python 3
vanilla='false'
VENV_NAME=Python3

while getopts 've:' flag; do
  case "${flag}" in
    v) vanilla='true';;
    e) VENV_NAME="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

brew bundle install

pip3 install virtualenv

virtualenv -p python3 $HOME/Applications/$VENV_NAME
source $HOME/Applications/$VENV_NAME/bin/activate

pip install jupyter notebook
if [ ${vanilla} = 'false' ]
then
   . ./opencv.zsh -e $VENV_NAME
fi
