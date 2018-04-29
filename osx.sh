#!/bin/bash

# ask for the administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Setting up Mac OS X apps and preferences..."

## Trackpad

# disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# enable tap to click for the login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## Dock

# automatically hide and show
defaults write com.apple.dock autohide -bool true

# remove all default icons
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# add Downloads folder
FOLDER_HEAD="<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>"
FOLDER_TAIL="</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
defaults write com.apple.dock persistent-others -array-add "$FOLDER_HEAD$HOME/Downloads$FOLDER_TAIL"

killall Dock

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


killall SystemUIServer

# Install all available updates
sudo softwareupdate -ia --verbose
