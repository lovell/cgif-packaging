#!/usr/bin/env bash
set -e

# sudo apt-get install dh-make dpkg-dev dput-ng

if [ $# -lt 2 ]; then
  echo
  echo "Usage: $0 UBUNTU_DISTRIBUTION CGIF_VERSION"
  echo
  echo "UBUNTU_DISTRIBUTION is one of focal, impish"
  echo "CGIF_VERSION is the semver to use in the PPA e.g. 0.0.0"
  echo
  exit 1
fi

UBUNTU_DISTRIBUTION="$1"
CGIF_VERSION="$2"
PPA_VERSION="${CGIF_VERSION}~ppa1~${UBUNTU_DISTRIBUTION}1"
DIR="cgif-${PPA_VERSION}"

mkdir ${DIR}
curl -Ls https://github.com/dloebl/cgif/archive/V${CGIF_VERSION}.tar.gz | tar xzC ${DIR} --strip-components=1
cp -r debian ${DIR}
cd ${DIR}
rm -rf .github/ cgif_example*
sed -i -e "s/PPA_VERSION/${PPA_VERSION}/" debian/changelog
sed -i -e "s/UBUNTU_DISTRIBUTION/${UBUNTU_DISTRIBUTION}/" debian/changelog

dh_make --createorig --defaultless --library --yes || true
dpkg-buildpackage --build=source --no-check-builddeps --sign-key=759AA500523F3968D1E8A1C7E9AA0283E2A8DB1A

echo "Upload to PPA by running:"
echo "dput ppa:lovell/cgif cgif_${PPA_VERSION}_source.changes"
