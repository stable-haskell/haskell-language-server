#!/bin/bash

if [ "${RUNNER_OS}" = "Windows" ] ; then
	ext=".exe"
else
	ext=''
fi

if [ "${RUNNER_OS}" = "Windows" ] ; then
    # on windows use pwd to get unix style path
    CI_PROJECT_DIR="$(pwd)"
    export CI_PROJECT_DIR
    export CABAL_DIR="C:\\Users\\runneradmin\\AppData\\Roaming\\cabal"
else
    export CI_PROJECT_DIR="${GITHUB_WORKSPACE}"
    export CABAL_DIR="$CI_PROJECT_DIR/cabal"
fi

export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Singapore
