#!/bin/zsh
brew bundle install

if (( ! $+commands[pipenv] )); then
   echo "pipenv not found."
   exit(1)
fi

if (( ! $+commands[pyopencv] )); then
   cd ../py4ds
   loc=`pwd`
   cd -
   alias pyopencv=${loc}/pyopencv.zsh
   echo "alias pyopencv=${loc}/pyopencv.zsh" >> ~/.zshrc
fi

mkdir -p $HOME/Applications/r4ds-py3
cp ./pipenv $HOME/Applications/r4ds-py3
cd $HOME/Applications/r4ds-py3

pipenv --three
pipenv install numpy

cd -

if (( ! $+commands[Rscript] )); then
   echo "Something went wrong during R install. Please retry."
   exit(1)
fi

sudo -s -- << EOF
if [[ -f /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist ]]; then
  launchctl unload -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
fi
cp /usr/local/opt/rstudio-server/extras/launchd/com.rstudio.launchd.rserver.plist /Library/LaunchDaemons/
launchctl load -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
cp /usr/local/opt/rstudio-server/extras/pam/rstudio /etc/pam.d/

if [[ ! -d /etc/rstudio ]]; then
  mkdir -p /etc/rstudio
  chmod +w /etc/rstudio
  echo "auth-minimum-user-id=500" > /etc/rstudio/rserver.conf
  chmod go-w /etc/rstudio
fi
EOF

defaults write org.R-project.R force.LANG en_US.UTF-8
Rscript required.R

