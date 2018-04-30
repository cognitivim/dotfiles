#!/bin/bash


echo "Node installation..." 


VERSION=${1}

brew install node@${1}
# brew unlink node
brew link node@${1} --force

echo "Done."
