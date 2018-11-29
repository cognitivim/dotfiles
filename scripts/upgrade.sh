#!/usr/bin/env bash

## mas

mas upgrade

## brew

brew update
brew upgrade

brew cleanup
brew prune
brew doctor

## brew cask

brew cask upgrade
brew cask doctor

## npm

# npm -g update
# npm update
# npm i -g npm
