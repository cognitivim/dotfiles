#!/usr/bin/env bash

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

# auto login
sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser $(whoami)

# always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# play sound feedback when adjusting volume
defaults write -g com.apple.sound.beep.feedback -int 1

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# screencapture: save to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# screencapture: save in PNG format
defaults write com.apple.screencapture type -string "png"

# Spotlight: exclude Downloads folder 
sudo defaults write /.Spotlight-V100/VolumeConfiguration.plist Exclusions -array-add "$HOME/Downloads"
touch ~/Downloads/.metadata_never_index

# disable autocorrect
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# iTunes: stop responding to the keyboard media keys
# launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# show fast user switching menu as: Account Name
# defaults write -g userMenuExtraStyle -int 1

# allow text selection in Quick Look
# defaults write com.apple.finder QLEnableTextSelection -bool true

# disabling automatic termination of inactive apps
# defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# automatically illuminate built-in MacBook keyboard in low light
# defaults write com.apple.BezelServices kDim -bool true

# turn off keyboard illumination when computer is not used for 5 minutes
# defaults write com.apple.BezelServices kDimTime -int 300

# set keyboard repeat rate to "damn fast".
# defaults write NSGlobalDomain KeyRepeat -int 2

# enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# enable HiDPI display modes (requires restart)
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# zoom: Options… > Use scroll wheel with modifier keys to zoom: ^ [control]
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask 262144

# zoom: Options… > Disable zoom with cmd+scroll
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool false

# theme mode
# defaults write NSGlobalDomain AppleInterfaceStyle Dark

# hide macOS unused folders
chflags -h hidden $HOME/Documents
chflags -h hidden $HOME/Movies
chflags -h hidden $HOME/Music
chflags -h hidden $HOME/Pictures

# Stop iTunes from responding to the keyboard media keys
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

## Language & Region

# setup system lanuages (in order of preference)
# defaults write NSGlobalDomain AppleLanguages -array "en-US" "ru"

# add english & russian keyboard layout
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>'
defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>1</integer><key>KeyboardLayout Name</key><string>Russian</string></dict>'

# show language menu in the top right corner of the boot screen
# sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

# set time zome automatically using current location
sudo defaults write /Library/Preferences/com.apple.timezone.auto.plist Active -bool true

# set language and text formats
# defaults write NSGlobalDomain AppleLanguages -array "en"
# defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
# defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
# defaults write NSGlobalDomain AppleMetricUnits -bool true


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

# require administrator auth to change network
/usr/libexec/airportd prefs RequireAdminNetworkChange=YES RequireAdminIBSS=YES

# require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0


## Trackpad

# disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# enable tap to click for the active user
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# enable tap to click for the login screen
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
# Reference http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns

# defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"
# EEE d MMM  HH:mm = Sun 20 Jul  13:15
# defaults write com.apple.menuextra.clock DateFormat "EEE d MMM  HH:mm"


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

# add Launchpad
APP_HEAD="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>"
APP_TAIL="</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
defaults write com.apple.dock persistent-apps -array-add "$APP_HEAD/Applications/Launchpad.app$APP_TAIL"

# don’t automatically rearrange Spaces based on most recent use
# defaults write com.apple.dock mru-spaces -bool false


## Dashboard

# disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true


## Desktop
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Library/Desktop Pictures/Mojave Night.jpg"'
# screensaver kill
# defaults write com.apple.screensaver idleTime -int 0
# defaults -currentHost write com.apple.screensaver idleTime -int 0


## Finder 

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# show library
# chflags nohidden ~/Library

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
# defaults write com.apple.finder FXPreferredViewStyle Nlsv

# set Desktop as default location for new Finder windows
# for other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# use current directory as default search scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# show external drive icons
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# show mounted server icons
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# show removable media icons
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true


## App Store

# enable the automatic update check
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# check for software updates daily, not just once per week
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# download newly available updates in background
# defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# install System data files & security updates
# defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1


## Terminal

# only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4


## TextEdit

# use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# open and save files as UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4


## Safari

# don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


## Photos

# prevent opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


## Printer

# automatically quit printer app once the print jobs complete
# defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true


## Time Machine

# prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


## Mail

# copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# "TB Item Identifiers" is the interesting item column
defaults write com.apple.mail "NSToolbar Configuration MainWindow" -dict \
  "TB Default Item Identifiers" '("checkNewMail:","showComposeWindow:",NSToolbarSpaceItem,NSToolbarFlexibleSpaceItem,"delete_junk","reply_replyAll_forward",FlaggedStatus,NSToolbarFlexibleSpaceItem,Search)' \
  "TB Display Mode" 2 \
  "TB Icon Size Mode" 1 \
  "TB Is Shown" 1 \
  "TB Item Identifiers" '("checkNewMail:",NSToolbarFlexibleSpaceItem,Search)' \
  "TB Size Mode" 1


## iCal

# day start 9:00, end at 18:00
defaults write com.apple.iCal "first minute of work hours" $((9 * 60))
defaults write com.apple.iCal "last minute of work hours" $((18 * 60))

defaults write com.apple.iCal "first minute of day time range" 0
defaults write com.apple.iCal "last minute of day time range" $((24 * 60))

defaults write com.apple.iCal "n days of week" 7

defaults write com.apple.iCal "number of hours displayed" 18


## Chrome

# make Google Chrome Canary the default browser
defaults write com.google.Chrome.canary DefaultBrowserSettingEnabled -bool true

# expand the print dialog by default
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true


## Kill affected applications

for app in "Dock" \
 "Finder" \
 "Safari" \
 "SystemUIServer" \
 "Photos" \
 "iCal" \
 "Mail"; do
    killall "${app}" &> /dev/null
done


# Install all available updates
sudo softwareupdate -ia --verbose


echo "Done. Note that some of these changes require a logout/restart to take effect."
