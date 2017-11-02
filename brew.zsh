#!/bin/zsh
# Basics
brew install rlwrap
brew install apache-spark
brew install storm
brew install wget
brew install node
brew install libssh2
brew cask install java

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
brew install numpy --with-python3
brew install --HEAD --with-tbb --with-contrib --with-python3 opencv3

# Julia
brew tap homebrew/science
brew cask install julia

# R
brew install R
brew install homebrew/science/rstudio-server
brew install jpeg libpng libtiff openexr

# Data Sicence
brew install vowpal-wabbit

# Big Data
brew install presto


