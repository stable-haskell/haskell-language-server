#!/bin/bash

. .github/scripts/env.sh

# Colors
RED="0;31"

ecabal() {
	cabal "$@"
}

emake() {
	if command -v gmake >/dev/null 2>&1 ; then
		gmake "$@"
	else
		make "$@"
	fi
}

mktempdir() {
	case "$(uname -s)" in
		"Darwin"|"darwin")
			mktemp -d -t hls_ci.XXXXXXX
			;;
		*)
			mktemp -d
			;;
	esac
}

echo_color() {
  local color="$1"
  local msg="$2"
  echo -e "\033[${color}m${msg}\033[0m"
}

error() { echo_color "${RED}" "$1"; }

fail() { error "error: $1"; exit 1; }
