#!/bin/zsh
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
