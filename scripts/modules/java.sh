#!/usr/bin/env bash

# echo "[java] install..." 

# VERSION=${1}
# brew cask install java${1}

echo "[java] setup..."

java -version
echo 'export JAVA_HOME=$(/usr/libexec/java_home)' >> ~/.bash_profile

echo "[java] done."
