#!/bin/zsh
# Node libraries
npm install -g @angular/cli
npm install -g npm-check-updates

apm install markdown-preview
apm install markdown-preview
apm install atom-icons
apm install data-atom
apm install python-autopep

# hydrogen requires python 2
export PATH=`which python2`:$PATH
apm install hydrogen
