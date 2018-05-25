#!/bin/bash
# commandline tools

# setup zprezto
setup_prezto (){
  if [ -f ~/.zshrc ]; then
     mv ~/.zshrc ~/.zshrc.old
  fi

  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  zsh
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  # setup the clarity theme
  cp themes/prompt_clarity_setup "${ZDOTDIR:-$HOME}/.zprezto/modules/prompt/functions/"
  sed -i .bak "s/^\(zstyle ':prezto:module:prompt' theme \).*/\1'clarity'/g" "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/zpreztorc
  rm -f "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/*.bak
  chsh -s /bin/zsh
}

install_brew (){
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # Fonts
  brew tap caskroom/fonts
  brew cask install font-fira-code

  # Cursive font Script 12 BT
  brew cask install ./font-script12-bt.rb
}
setup_prezto
install_brew

xcode-select --install

# oh-my-zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# brew

# zsh theme
pwd

if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi
cp themes/template.vimrc ~/.vimrc

if [ ! -d ~/.atom ]; then
  mkdir -p ~/.atom
fi

#cp themes/clarity.zsh-themes ~/.oh-my-zsh/themes/.
if [ -f ~/.atom/styles.less ]; then
  mv ~/.atom/styles.less ~/.atom/styles.old
fi
cp themes/styles.less ~/.atom


#sed 's/robbyrussel/clarity/' ~/.zshrc.old > ~/.zshrc

# terminal colors



chmod 700 brew.zsh
chmod 700 node.zsh
# Brew apps
./brew.zsh
# Node libraries
./node.zsh
# Python3
