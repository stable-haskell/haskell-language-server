#!/bin/bash

set -eu
set -o pipefail

RELEASE=$1

cd "gh-release-artifacts/haskell-language-server-${RELEASE}"
baseUrl="https://downloads.haskell.org/~ghcup/unofficial-bindists/haskell-language-server/$RELEASE"

cat <<EOF > /dev/stdout
    $RELEASE:
      viTags:
        - Latest
      viChangeLog: https://github.com/haskell/haskell-language-server/blob/master/ChangeLog.md
      viPostInstall: *hls-post-install
      viSourceDL:
        dlUri: $baseUrl/haskell-language-server-$RELEASE-src.tar.gz
        dlSubdir: haskell-language-server-$RELEASE
        dlHash: $(sha256sum "haskell-language-server-$RELEASE-src.tar.gz" | awk '{ print $1 }')
      viArch:
        A_64:
          Linux_Debian:
            '< 11': &hls-${RELEASE//./}-64-deb10
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-deb10.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-deb10.tar.xz" | awk '{ print $1 }')
            '(>= 11 && < 12)': &hls-${RELEASE//./}-64-deb11
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-deb11.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-deb11.tar.xz" | awk '{ print $1 }')
            '(>= 12 && < 13)': &hls-${RELEASE//./}-64-deb12
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-deb12.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-deb12.tar.xz" | awk '{ print $1 }')
            unknown_versioning: *hls-${RELEASE//./}-64-deb12
          Linux_Ubuntu:
            '< 22': &hls-${RELEASE//./}-64-ubuntu20
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-ubuntu20.04.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-ubuntu20.04.tar.xz" | awk '{ print $1 }')
            '( >= 22 && < 24 )': &hls-${RELEASE//./}-64-ubuntu22
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-ubuntu22.04.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-ubuntu22.04.tar.xz" | awk '{ print $1 }')
            '( >= 24 && < 25 )': &hls-${RELEASE//./}-64-ubuntu24
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-ubuntu24.04.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-ubuntu24.04.tar.xz" | awk '{ print $1 }')
            unknown_versioning: *hls-${RELEASE//./}-64-ubuntu22
          Linux_Mint:
            '< 21': &hls-${RELEASE//./}-64-mint20
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-mint20.3.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-mint20.3.tar.xz" | awk '{ print $1 }')
            '(>= 21 && < 22)': &hls-${RELEASE//./}-64-mint21
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-mint21.3.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-mint21.3.tar.xz" | awk '{ print $1 }')
            unknown_versioning: *hls-${RELEASE//./}-64-mint21
          Linux_Fedora:
            unknown_versioning: &hls-${RELEASE//./}-64-fedora33
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-fedora33.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-fedora33.tar.xz" | awk '{ print $1 }')
          Linux_Rocky:
            '( >= 8 && < 9 )': &hls-${RELEASE//./}-64-rocky8
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-rocky8.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-rocky8.tar.xz" | awk '{ print $1 }')
            '( >= 9 && < 10 )': &hls-${RELEASE//./}-64-rocky9
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-rocky9.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-rocky9.tar.xz" | awk '{ print $1 }')
            unknown_versioning: *hls-${RELEASE//./}-64-rocky9
          Linux_RedHat:
            unknown_versioning: *hls-${RELEASE//./}-64-rocky8
          Linux_UnknownLinux:
            unknown_versioning: *hls-${RELEASE//./}-64-rocky8
          Linux_Alpine:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-linux-alpine.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-linux-alpine.tar.xz" | awk '{ print $1 }')
          Darwin:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-apple-darwin.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-apple-darwin.tar.xz" | awk '{ print $1 }')
          Windows:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-mingw64.zip
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-mingw64.zip" | awk '{ print $1 }')
          FreeBSD:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-x86_64-portbld-freebsd.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-x86_64-portbld-freebsd.tar.xz" | awk '{ print $1 }')
        A_ARM64:
          Linux_UnknownLinux:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-aarch64-linux-deb10.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-aarch64-linux-deb10.tar.xz" | awk '{ print $1 }')
          Darwin:
            unknown_versioning:
              dlUri: $baseUrl/haskell-language-server-$RELEASE-aarch64-apple-darwin.tar.xz
              dlSubdir: haskell-language-server-$RELEASE
              dlHash: $(sha256sum "haskell-language-server-$RELEASE-aarch64-apple-darwin.tar.xz" | awk '{ print $1 }')
EOF

