#! /usr/bin/env bash
#
# install-wasi-sdk.bash
# Copyright (C) 2025 Shlomi Fish < https://www.shlomifish.org/ >
#
# Distributed under the terms of the MIT license.
#

set -e -x -o pipefail

name="$1"
shift
test "${name}" = "--GITHUB_ENV"
GITHUB_ENV="$1"
shift
test -n "${GITHUB_ENV}"
# Create directory for WASI SDK
sudo mkdir -p /opt/wasi-sdk

# Set variables for WASI SDK installation
WASI_OS=linux
WASI_ARCH=x86_64
WASI_VERSION=25
WASI_VERSION_FULL=${WASI_VERSION}.0

# Download and extract WASI SDK
cd /tmp
wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_VERSION}/wasi-sdk-${WASI_VERSION_FULL}-${WASI_ARCH}-${WASI_OS}.tar.gz
sudo tar xvf wasi-sdk-${WASI_VERSION_FULL}-${WASI_ARCH}-${WASI_OS}.tar.gz -C /opt/wasi-sdk --strip-components=1

# Verify installation
ls -la /opt/wasi-sdk/bin

# Make available in the current job
echo "WASI_SDK_PATH=/opt/wasi-sdk" >> $GITHUB_ENV
echo "PATH=/opt/wasi-sdk/bin:$PATH" >> $GITHUB_ENV
