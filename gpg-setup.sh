#!/bin/bash

mkdir -p ~/.gnupg

# change Pinentry to pinentry-mac
if type pinentry-mac > /dev/null 2>&1; then
  echo "pinentry-program $(which pinentry-mac)" > ~/.gnupg/gpg-agent.conf
  gpgconf --kill gpg-agent
else
  echo "pinentry-mac not found"
  exit 1
fi

chmod 700 ~/.gnupg
gpg --list-keys

echo 'Next step: gpg --full-generate-key'
echo 'The pub key can be obtained with: gpg --armor --export XXXXXXXXXXX'
echo 'In git config, edit the following items:'
echo '  commit.gpgsign true'
echo '  user.signingkey ""'
echo '  user.email "xxxx@yyy.com"'
echo '  user.name "ryota2357"'
