#!/usr/bin/env bash

# echo "Java installation..." 
# VERSION=${1}
# brew cask install java${1}

java -version
echo 'export JAVA_HOME=$(/usr/libexec/java_home)' >> ~/.bash_profile

# echo "Done."
