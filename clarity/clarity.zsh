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

# History settings
export HISTFILE=$HOME/.zhistory
export EDITOR=vi
export HISTSIZE=50000
export SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

function dotenv{
  `sed -e 's/^/export /' .env`
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
  ORIG=`brew ls opencv3 | grep $VERSION | grep site-packages`
  ln -s $ORIG $VENV/lib/$VERSION/site-packages/cv2.so
}