#!/usr/bin/env bash

echo "[xcode-tools] install..."


#if [[ ! -z "/Library/Developer/CommandLineTools/" ]]; then
  if ! $(xcode-select -p &>/dev/null); then
    # see http://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line
    
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
      echo "[xcode-tools] license accepting..."
      sudo xcodebuild -license accept
    fi
    echo "[xcode-tools] done."
  else
    echo "[xcode-tools] Xcode CLI tools is already installed!"
  fi
#else
#  # choosing command line tools as default
#  sudo xcode-select --switch /Library/Developer/CommandLineTools/
#  echo "[xcode-tools] done."
#fi
