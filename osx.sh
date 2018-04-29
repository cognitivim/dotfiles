#!/bin/bash

# ask for the administrator password upfront
# cache the root password
sudo -v

# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "Setting up Mac OS X apps and preferences..."

## General

# set computer name
HOSTNAME="marina-mac"
sudo scutil --set ComputerName $HOSTNAME
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $HOSTNAME

# always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# disable autocorrect
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

## Security

# disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# allow applications downloaded from anywhere
sudo spctl --master-disable

# allow guests to login to this computer
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

## Trackpad

# disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# enable tap to click for the login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# enable 3-finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

## Menu bar

# show percentage charged battery
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# show volume
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"

# show bluetooth
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# set clock format:
#   "h:mm" Default
#   "HH"   Use a 24-hour clock
#   "a"    Show AM/PM
#   "ss"   Display the time with seconds

# defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

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

## Dashboard

# disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

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

echo "Done. Note that some of these changes require a logout/restart to take effect."
