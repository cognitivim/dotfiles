#!/bin/bash


echo "Yarn installation..." 

brew install yarn --without-node
# check
yarn -v

echo "Done."
