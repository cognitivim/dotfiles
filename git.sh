git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL
git config --global commit.gpgsign true

gpg --gen-key
gpg --list-keys
git config --global user.signingkey $GIT_SIGNKEY
gpg --armor --export $GIT_SIGNKEY

# Saving your passphrase
