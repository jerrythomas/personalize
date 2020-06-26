#!/bin/zsh
brew bundle install

if [ ! -d ~/.atom ]; then
  mkdir -p ~/.atom
fi

count=1
if [ -f ~/.atom/styles.less ]; then
   count=`diff ~/.atom/styles.less styles.less | wc -l`
   if [ $count -gt 0 ]; then
      mv ~/.atom/styles.less ~/.atom/styles.old
   fi
fi
if [ $count -gt 0 ]; then
   cp styles.less ~/.atom
fi

# hydrogen requires python 2
#ver=`python -c 'import sys; print(".".join(map(str, sys.version_info[:1])))'`
#if [ $ver -ne 2 ]
#then
#   export PATH=`which python2`:$PATH
#fi

apm install --packages-file atom-package-list.txt
#cat vscode-extensions.txt | xargs -L 1 code --install-extension

#cp code-settings.json ~/Library/Application\ Support/Code/User/settings.json
