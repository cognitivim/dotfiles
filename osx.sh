#!/bin/bash

# ask for the administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Setting up Mac OS X apps and preferences..."

## Finder 

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show tab bar
defaults write com.apple.finder ShowTabView -bool true

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar 
defaults write com.apple.finder ShowPathbar -bool true

# show side bar
defaults write com.apple.finder ShowSidebar -bool true

# use list view in all windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# set default location for new Finder windows
defaults write com.apple.finder NewWindowTargetPath "file://$HOME"

# automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

killall Finder
killall -HUP SystemUIServer

##

# Install all available updates
sudo softwareupdate -ia --verbose
