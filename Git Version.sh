#!/bin/bash
#
# Git Version
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 4/21/11.
# No Copyright Claimed. Public Domain.
#

INFO="${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/Info"
GITDIR="${PROJECT_DIR}/.git"

VERSION=`defaults read "${INFO}" CFBundleVersion`
if [ -d "${GITDIR}" ]; then
	REVISION=`git --git-dir="${GITDIR}" rev-parse --short HEAD`
	defaults write "${INFO}" CFBundleShortVersionString -string "${VERSION} (${REVISION})"
else
	defaults write "${INFO}" CFBundleShortVersionString -string "${VERSION}"
fi