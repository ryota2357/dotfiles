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
