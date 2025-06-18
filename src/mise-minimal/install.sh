#!/bin/sh
set -e

curl https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise sh
eval "$(mise activate --shims)"
mise doctor
echo 'eval "$(mise activate --shims)"' >> /etc/bash.bashrc
echo 'eval "$(mise activate --shims)"' >> /etc/zsh/zshrc
rm -rf /var/lib/apt/lists/*
