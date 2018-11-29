git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

# SIGN KEY

# generate:
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
# GPG_SIGNING_KEY=$(gpg --list-keys --keyid-format LONG | grep 'pub ' | sed 's/.*\///g; s/ .*//g')

# setup git:
git config --global user.signingkey $GPG_KEYID
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global gpg.program "$(which gpg)"
# git config --global credential.helper osxkeychain
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
echo 'export GPG_TTY=$(tty)' >> ~/.profile

# setup github:
gpg --armor --export $GPG_KEYID
# ... add to github

# setup agent:
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 864000" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl-ssh 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl-ssh 864000" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

# echo "default-key <keyid>" >> ~/.gnupg/gpg.conf
