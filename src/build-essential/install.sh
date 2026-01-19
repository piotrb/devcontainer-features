#!/bin/bash
set -e -o pipefail
set -x

apt-get update -y
apt-get -y install --no-install-recommends build-essential
rm -rf /var/lib/apt/lists/*
