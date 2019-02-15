#!/bin/zsh
# Language UTF-8
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# History settings
export HISTFILE=$HOME/.zhistory
export EDITOR=vi
export HISTSIZE=50000
export SAVEHIST=10000

# Fix compilation issue for Rxml2
if [ -d "/usr/local/opt/libxml2" ]
then
  export PATH="/usr/local/opt/libxml2/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/libxml2/lib"
  export CPPFLAGS="-I/usr/local/opt/libxml2/include"
  export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"
fi

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# set private environment variables for project
function dotenv {
  script=".dotenv.sh"
  if [ -f $script ]; then
    rm -f $script
  fi
  sed -e 's/^/export /' .env > $script
  . ./$script
  rm -f $script
}

function pyopencv {
  if (( ! $+commands[pipenv] ))
  then
     echo "pipenv does not exist."
     exit(1)
  fi

  if (( ! $+commands[opencv_version] )); then
     echo "OpenCV is not installed"
     exit(1)
  fi

  VENV=`pipenv --venv`
  VERSION=`ls $VENV/lib/ | grep python`
  ORIG=`brew ls opencv3 | grep $VERSION | grep .so | grep site-packages`
  ln -s $ORIG $VENV/lib/$VERSION/site-packages/cv2.so
}

# List or create a file with the current atom packages
function atom_package_list() {
  if [ $# -eq 0 ]
  then
    apm list --installed --bare | grep '^[^@]\+' -o
  else
    PKG_FILE=$1
    if [ -f $PKG_FILE ]; then
       rm -f $PKG_FILE
    fi
    apm list --installed --bare | grep '^[^@]\+' -o > $PKG_FILE
  fi
}

function grep_history() {
  if [ $# -eq 0 ]
  then
    history
  else
    WORDS="$@"
    cat $HISTFILE | cut -d";" -f2 | grep "$WORDS"
  fi
}

# Create a fresh angular project with material theme
function angular() {
  project=$1
  ng new $project --style=scss --routing
  cd $project

  ng add @angular/pwa
  ng add @angular/material
  # Install missing peer dependencies (ajv)  
  npm install --save @angular/material @angular/cdk @angular/animations hammerjs ajv
}

# Upgrade all outdated global packages
function ncu-g() {
  `ncu -g | grep "npm -g"`
}