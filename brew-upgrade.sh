#!/bin/bash

brew update
brew upgrade

brew cleanup
brew prune
brew doctor

brew cask upgrade
brew cask doctor

# update npm
npm -g update
npm update
npm i -g npm
