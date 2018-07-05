#!/bin/zsh
brew cask install atom

if [ ! -d ~/.atom ]; then
  mkdir -p ~/.atom
fi

count=1
if [ -f ~/.atom/styles.less ]; then
   count=`diff ~/.atom/styles.less ~/Code/personalize/themes/styles.less | wc -l`
   if [ $count -gt 0 ]; then
      mv ~/.atom/styles.less ~/.atom/styles.old
   fi
fi
if [ $count -gt 0 ]; then
   cp themes/styles.less ~/.atom
fi

apm install atom-icons
apm install data-atom
apm install python-autopep8

# hydrogen requires python 2

ver=`python -c 'import sys; print(".".join(map(str, sys.version_info[:1])))'`
if [ $ver -ne 2 ]
then
   export PATH=`which python2`:$PATH
fi
apm install hydrogen
