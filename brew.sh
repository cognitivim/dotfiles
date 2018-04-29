#!/bin/bash

# ask for the administrator password upfront
# cache the root password
sudo -v

# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Homebrew installation..." 


if test ! $(which brew); then 
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # install brew-cask, if it's not already installed
  if ! brew list | grep -q brew-cask ; then
      brew tap caskroom/cask
      #  brew unlink brew-cask && brew link brew-cask

      # http://docs.brew.sh/Troubleshooting.html
      cd /usr/local && sudo chown -R $(whoami) bin etc include lib sbin share var Frameworks
  fi

  # allow installing non-standard versions of packages
  # brew tap caskroom/versions
else
  echo "Brew is already installed!"
fi

echo "Updating Homebrew formulas ..."

brew update &&
brew upgrade brew-cask &&
brew cleanup &&
brew cask cleanup

# check for issues. set permissions (prompting for sudo password) if necessary
brew cask doctor
brew doctor

echo "Done."
