#!/usr/bin/env bash
set -e

# sudo apt-get install dh-make dpkg-dev dput-ng

TAG="${1:-main}"
VERSION="${2:-0.0.1}"
PPA_VERSION="${VERSION}~ppa1~ubuntu20.04.1"
DIR="cgif-${PPA_VERSION}"

mkdir ${DIR}
curl -Ls https://github.com/dloebl/cgif/archive/refs/heads/${TAG}.tar.gz | tar xzC ${DIR} --strip-components=1
cp -r debian ${DIR}
cd ${DIR}
rm -rf .github/ cgif_example*
sed -i -e "s/PPA_VERSION/${PPA_VERSION}/g" debian/changelog

dh_make --createorig --defaultless --library --yes || true
dpkg-buildpackage --build=source --no-check-builddeps --sign-key=759AA500523F3968D1E8A1C7E9AA0283E2A8DB1A

echo "Upload to PPA by running:"
echo "dput ppa:lovell/focal-cgif cgif_${PPA_VERSION}_source.changes"
