#!/bin/zsh
# Install brew if not already installed
if [ -z `which brew` ]; then
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Defaults for dock, trackpad, mouse, terminal
cd clarity
zsh ./setup.zsh

res=`mas signin $1`
if [ `echo $res | grep -i "already signed in" | wc -l` -ne 1 ]; then
    echo "Failed to sign in to mac app store $1"
    echo $res
fi
cd ..
