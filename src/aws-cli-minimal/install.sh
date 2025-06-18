#!/bin/bash
set -e -o pipefail
set -x

architecture=$(dpkg --print-architecture)
case "${architecture}" in
    amd64) architectureStr=x86_64 ;;
    arm64) architectureStr=aarch64 ;;
    *)
        echo "AWS CLI does not support machine architecture '$architecture'. Please use an x86-64 or ARM64 machine."
        exit 1
esac

curl "https://awscli.amazonaws.com/awscli-exe-linux-${architectureStr}.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip
rm -rf /var/lib/apt/lists/*
