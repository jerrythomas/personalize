#!/bin/zsh
# check success of shell scripts.

pip3 install virtualenv

virtualenv -p python3 ~/Applications/Python3
source ~/Applications/Python3/bin/activate

pip install jupyter notebook
