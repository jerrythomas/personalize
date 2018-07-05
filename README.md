# Personalize

A mini repo to quickly set up a new mac with my preferred settings.

### Basics

* commandline tools
* ZSH using oh-my-zsh
* homebrew

Languages and packages

* Terminal & ZSH theme
* Brew packages
* Python packages
* R packages
* Node libraries

## Atom Editor

Preview of the editor using the fonts [Fira Code](https://github.com/tonsky/FiraCode) and [Script 12 BT](https://www.wfonts.com/font/script12-bt)
![editor](preview/editor.png)

Minimal set of atom plugins

* markdown preview
* markdown pdf
* data atom
* hydrogen

### Usage

```bash
 git clone https://github.com/jerrythomas/personalize

 cd personalize

 . ./brew.zsh
 . ./node.zsh
 . ./java.zsh

 cd atom & . ./atom.zsh
 cd ../cloud & brew bundle install
 cd ../data & brew bundle install
 cd ../r4ds & . ./r4ds.zsh
 cd ../py4ds & . ./python3.zsh
 cd ../flutter & brew install ./flutter.rb
 cd ..

```
