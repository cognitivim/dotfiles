git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL

# https://help.github.com/articles/generating-a-new-gpg-key/

# gen
gpg --full-generate-key
# ...

# gpg --list-secret-keys --keyid-format LONG
# ... set $GPG_KEYID

# git
git config --global user.signingkey $GPG_KEYID
git config --global commit.gpgsign true
# git config --global credential.helper osxkeychain
# git config gpg.program gpg2
# ?
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
echo 'export GPG_TTY=$(tty)' >> ~/.profile

# github
gpg --armor --export $GPG_KEYID

# agent
# cat ~/.gnupg/gpg-agent.conf 
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 864000" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl-ssh 86400" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl-ssh 864000" >> ~/.gnupg/gpg-agent.conf

# echo "default-key <keyid>" >> ~/.gnupg/gpg.conf

killall gpg-agent
