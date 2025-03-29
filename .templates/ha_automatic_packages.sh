#!/bin/bash
# shellcheck disable=SC2015
set -e

############################
# Apt based installs       #
############################

# Global variables
PACKAGES="$1"
ARCH=$(uname -m)
FILENAME="/etc/cont-init.d/98-packages"

# Make sure the architecture is supported
if [ "${ARCH}" = "x86_64" ]; then
  ARCH="amd64"
elif [ "${ARCH}" = "aarch64" ]; then
  ARCH="arm64"
elif [ "${ARCH}" = "armv7l" ]; then
  ARCH="armhf"
fi

# Check for specific platform binaries
if command -v apk >/dev/null 2>/dev/null; then
    # Alpine
    echo "Installing packages on Alpine: $PACKAGES"
    # shellcheck disable=SC2086
    apk add --no-cache $PACKAGES
elif command -v apt-get >/dev/null 2>/dev/null; then
    # Ubuntu/Debian
    echo "Installing packages on Ubuntu/Debian: $PACKAGES"
    apt-get update
    # shellcheck disable=SC2086
    apt-get install -yqq --no-install-recommends $PACKAGES
elif command -v dnf >/dev/null 2>/dev/null; then
    # Fedora/CentOS
    echo "Installing packages on Fedora/CentOS: $PACKAGES"
    # shellcheck disable=SC2086
    dnf install -y $PACKAGES
else
    echo "No package manager found. Manual installation may be required."
    exit 0
fi

# Install bashio if required
if [ ! -f /usr/bin/bashio ]; then
    echo "Installing bashio..."
    mkdir -p /tmp/bashio
    curl -L -s "https://github.com/hassio-addons/bashio/archive/v0.15.0.tar.gz" | tar -xzf - -C /tmp/bashio
    mv /tmp/bashio/bashio-*/lib /usr/lib/bashio
    ln -s /usr/lib/bashio/bashio /usr/bin/bashio
    rm -rf /tmp/bashio
fi

echo "Package installation completed"
exit 0 