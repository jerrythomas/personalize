#!/bin/zsh
# check success of shell scripts.

# Python 3
brew install python3
brew install --build-from-source --with-python3 --fresh -vd boost boost-python
brew install --build-from-source --with-python3 --devel -vd protobuf
brew install numpy
brew install opencv3

pip3 install virtualenv

virtualenv -p python3 $HOME/Applications/Python3
source $HOME/Applications/Python3/bin/activate

pip install jupyter notebook
zsh opencv.zsh Python3
