read -r -t 60 -p "GIT USERNAME=" GIT_USERNAME
read -r -t 60 -p "GIT EMAIL=" GIT_EMAIL

git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

## SIGN KEY

# generate:
gpg --full-generate-key
GIT_SIGNKEY=$(gpg --list-keys --keyid-format LONG | grep 'pub ' | sed 's/.*\///g; s/ .*//g')

# setup git:
git config --global user.signingkey $GIT_SIGNKEY
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global gpg.program "$(which gpg)"
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
echo 'export GPG_TTY=$(tty)' >> ~/.profile

# setup github:
gpg --armor --export $GIT_SIGNKEY
echo -e "\nAdd this gpg key to github.\n"

# setup agent:
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 864000" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl-ssh 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl-ssh 864000" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent
