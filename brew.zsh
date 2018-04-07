#!/bin/zsh
# Basics
brew install rlwrap
brew install apache-spark
brew install storm
brew install wget
brew install node
brew install libssh2
brew cask install java
brew install p7zip

# Development
brew install llvm
brew install gfortran
brew install gcc --without-multilib
brew install lpSolve
brew install heroku

# Parallel processing
brew install libomp

# Databases
brew install postgresql
brew install mongodb
brew install mariadb

# Python 3
brew install python3
brew install --build-from-source --with-python3 --fresh -vd boost boost-python
brew install --build-from-source --with-python3 --devel -vd protobuf

brew install numpy
brew install opencv3

zsh python3.zsh
# Julia
brew tap homebrew/science
brew cask install julia

# R
brew install R
brew install homebrew/science/rstudio-server
brew install jpeg libpng libtiff openexr

# IDE
brew cask install caskroom/cask/intellij-idea-ce
brew cask install atom

# dependencies for bookdown
brew install pandoc pandoc-citeproc
brew cask install mactex

# Data Sicence
brew install vowpal-wabbit

# Big Data
brew install presto
