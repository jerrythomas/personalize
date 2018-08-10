#!/bin/zsh
# Install brew if not already installed
if ! (( $+commands[brew] )); then
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! (( $+commands[brew] )); then
   echo "Brew installation failed."
   exit(1)
fi
# Defaults for dock, trackpad, mouse, terminal
cd clarity
zsh ./setup.zsh

if [ ${SHELL} != `which zsh` ]; then
   chsh -s `which zsh`
fi

if (( $+commands[mas] )); then
   res=`mas signin $1`
   if [ `echo $res | grep -i "already signed in" | wc -l` -ne 1 ]; then
      echo "Failed to sign in to mac app store $1"
      echo $res
   fi
fi
cd ..
