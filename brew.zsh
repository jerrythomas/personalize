#!/bin/zsh
# Basics
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install rlwrap
brew install wget
brew install node
brew install libssh2
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
brew install cassandra
# Big Data
brew install presto

brew cask install robo-3t
brew cask install pgadmin-4
brew cask install docker
brew cask install virtualbox

# Julia
brew cask install julia





# Data Science
#brew install vowpal-wabbit
