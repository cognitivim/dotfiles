#!/bin/bash

echo "Java installation..." 


VERSION=${1}

brew cask install java${1}
# check
java -version

echo "Done."
