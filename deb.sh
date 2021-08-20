#!/usr/bin/env bash
set -e

# sudo apt-get install dh-make dpkg-dev dput-ng

DEFAULT_TAG=$(curl -Ls https://api.github.com/repos/dloebl/cgif/commits/main | jq -j '.sha' | head -c7)

if [ $# -lt 2 ]; then
  echo
  echo "Usage: $0 UBUNTU_DISTRIBUTION CGIF_VERSION [CGIF_TAG]"
  echo
  echo "UBUNTU_DISTRIBUTION is one of focal, hirsute"
  echo "CGIF_VERSION is the semver to use in the PPA e.g. 0.0.0+1"
  echo
  echo "CGIF_TAG is the git repo tag, defaults to ${DEFAULT_TAG}"
  exit 1
fi

UBUNTU_DISTRIBUTION="$1"
CGIF_VERSION="$2"
TAG="${3:-$DEFAULT_TAG}"
PPA_VERSION="${CGIF_VERSION}~ppa1~${UBUNTU_DISTRIBUTION}1"
DIR="cgif-${PPA_VERSION}"

mkdir ${DIR}
curl -Ls https://github.com/dloebl/cgif/archive/${TAG}.tar.gz | tar xzC ${DIR} --strip-components=1
cp -r debian ${DIR}
cd ${DIR}
rm -rf .github/ cgif_example*
sed -i -e "s/PPA_VERSION/${PPA_VERSION}/" debian/changelog
sed -i -e "s/UBUNTU_DISTRIBUTION/${UBUNTU_DISTRIBUTION}/" debian/changelog

dh_make --createorig --defaultless --library --yes || true
dpkg-buildpackage --build=source --no-check-builddeps --sign-key=759AA500523F3968D1E8A1C7E9AA0283E2A8DB1A

echo "Upload to PPA by running:"
echo "dput ppa:lovell/cgif cgif_${PPA_VERSION}_source.changes"
