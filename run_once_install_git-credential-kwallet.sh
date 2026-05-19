#!/bin/bash

# From https://codeberg.org/mehrad/git-credential-kwallet
wget -O "${HOME}/.local/bin/git-credential-kwallet" \
'https://codeberg.org/mehrad/git-credential-kwallet/raw/branch/main/git-credential-kwallet' \
&& chmod 0755 "${HOME}/.local/bin/git-credential-kwallet"
