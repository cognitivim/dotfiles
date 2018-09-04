#!/bin/bash

curl -LO https://github.com/FirebirdSQL/firebird/releases/download/R3_0_3/Firebird-3.0.3-32900-x86_64.pkg
open ./Firebird-3.0.3-32900-x86_64.pkg

firebirdHome='export FIREBIRD_HOME="/Library/Frameworks/Firebird.framework/Resources"'
grep -q -F "$firebirdHome" ~/.bash_profile || echo "$firebirdHome" >> ~/.bash_profile

firebirdBin='export PATH=$PATH:$FIREBIRD_HOME/bin'
grep -q -F "$firebirdBin" ~/.bash_profile || echo "$firebirdBin" >> ~/.bash_profile

# TODO wait finish install

# troubleshooting: Can not access lock files directory /tmp/firebird/
sudo dseditgroup -o edit -a $(whoami) -t user firebird
