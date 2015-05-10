#!/usr/bin/env bash
#
# Usage
#
#   VERSION=1.0 ./build.sh aur
#

set -e

main() {
  case "$1" in
    aur ) aur ;;
  esac
}

aur() {
  VERSION=$(cat ../VERSION)
  cd aur
  sed -i "s/pkgver=.*/pkgver=$VERSION/" PKGBUILD
  updpkgsums
  makepkg --source --force
  aurupload *.src.tar.gz
  cd -
}

main "$@"
