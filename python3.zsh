#!/bin/zsh
# check success of shell scripts.

pip3 install virtualenv

virtualenv -p python3 $HOME/Applications/Python3
source $HOME/Applications/Python3/bin/activate

pip install jupyter notebook
zsh opencv.zsh Python3
