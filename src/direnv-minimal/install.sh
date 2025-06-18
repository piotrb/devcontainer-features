#!/bin/bash
set -e -o pipefail
set -x

apt-get update -y
apt-get -y install --no-install-recommends direnv
echo 'eval "$(direnv hook bash)"' >> /etc/bash.bashrc
echo 'eval "$(direnv hook zsh)"' >> /etc/zsh/zshrc
rm -rf /var/lib/apt/lists/*
