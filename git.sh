git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_EMAIL
git config --global commit.gpgsign true

# gen
gpg --default-new-key-algo rsa4096 --gen-key
# ...

# git
gpg --list-secret-keys --keyid-format LONG
# ...
git config --global user.signingkey $GPG_KEYID
git config --global commit.gpgsign true
# ?
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
echo 'export GPG_TTY=$(tty)' >> ~/.profile


# gpg-agent, pinentry-mac


# If you need to have this software first in your PATH run:
#  echo 'export PATH="/usr/local/opt/gpg-agent/bin:$PATH"' >> ~/.bash_profile

# !! file ~/.gnupg/gpg.conf
# Uncomment within config (or add this line)
# This tells gpg to use the gpg-agent
use-agent

# !! file “~/.gnupg/gpg-agent.conf”
# Enables GPG to find gpg-agent
use-standard-socket
# Connects gpg-agent to the OSX keychain via the brew-installed
# pinentry program from GPGtools. This is the OSX 'magic sauce',
# allowing the gpg key's passphrase to be stored in the login
# keychain, enabling automatic key signing.
pinentry-program /usr/local/bin/pinentry-mac

# !! file ~/.bash_profile
# In order for gpg to find gpg-agent, gpg-agent must be running,
# and there must be an env variable pointing GPG to the gpg-agent socket.
# This little script, which must be sourced
# will either start gpg-agent or set up the
# GPG_AGENT_INFO variable if it's already running.
# Add the following
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --log-file /tmp/gpg.log --write-env-file ~/.gnupg/gpg-agent-info --pinentry-program /usr/local/bin/pinentry-mac)
fi
#$ echo $GPG_AGENT_INFO
#> /Users/home/.gnupg/agent-location


# github

gpg --armor --export $GPG_KEYID
# ...

# To sign a tag, add -s to your git tag command.
# When committing changes in your local branch, add the -S flag 
