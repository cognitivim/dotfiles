#!/usr/bin/env bash

echo "Installing Xcode CLI tools..."

#if [[ ! -z "/Library/Developer/CommandLineTools/" ]]; then
  if ! $(xcode-select -p &>/dev/null); then

    # See http://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
    TOOLS_PLACEHOLDER='/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress'
    touch "${TOOLS_PLACEHOLDER}"
    sleep 3
    TOOLS="$(softwareupdate --list | sed -E '/^.*\*\ *(Command Line Tools.*)\ *$/h;g;$!d;s//\1/')"
    softwareupdate --verbose --install "${TOOLS}"
    rm -f "${TOOLS_PLACEHOLDER}"

    # choosing command line tools as default    
    sudo xcode-select --switch /Library/Developer/CommandLineTools/

    # accept the Xcode/iOS license agreement
    if ! $(sudo xcodebuild -license status); then
      echo "License accepting..."
      sudo xcodebuild -license accept
    fi

    echo "Done."
  else
    echo "Xcode CLI tools is already installed!"
  fi
#else
#  # choosing command line tools as default
#  sudo xcode-select --switch /Library/Developer/CommandLineTools/
#  echo "Done."
#fi
