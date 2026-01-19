#!/bin/bash
set -e -o pipefail
set -x

GITHUB_REPO="jonas/tig"

# Install build dependencies
echo "Installing build dependencies..."
apt-get update
apt-get install -y build-essential libncursesw5-dev pkg-config curl jq
rm -rf /var/lib/apt/lists/*

# Determine the version to download
if [ "${VERSION}" = "latest" ]; then
    # Fetch the latest release tag
    RELEASE_TAG=$(curl -s "https://api.github.com/repos/${GITHUB_REPO}/releases/latest" | jq -r '.tag_name')
else
    RELEASE_TAG="tig-${VERSION}"
fi

# Remove 'tig-' prefix if present to get version number
VERSION_NUM="${RELEASE_TAG#tig-}"

# Download URL
DOWNLOAD_URL="https://github.com/${GITHUB_REPO}/releases/download/${RELEASE_TAG}/tig-${VERSION_NUM}.tar.gz"

echo "Downloading tig version ${VERSION_NUM} from ${DOWNLOAD_URL}..."
curl -L -o "/tmp/tig-${VERSION_NUM}.tar.gz" "${DOWNLOAD_URL}"

echo "Extracting tarball..."
tar -xzf "/tmp/tig-${VERSION_NUM}.tar.gz" -C /tmp

echo "Building tig..."
cd "/tmp/tig-${VERSION_NUM}"
make prefix=/usr/local

echo "Installing tig to /usr/local..."
make install prefix=/usr/local

echo "Cleaning up..."
cd /
rm -rf "/tmp/tig-${VERSION_NUM}" "/tmp/tig-${VERSION_NUM}.tar.gz"

echo "tig ${VERSION_NUM} installed successfully!"