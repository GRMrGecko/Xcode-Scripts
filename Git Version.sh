#!/bin/bash
#
# Git Version
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 4/21/11.
# No Copyright Claimed. Public Domain.
#
# DISCLAIMER: This script is provided as-is. I am not responsible if this script somehow causes harm to you or your system in any way, I am providing this for free in hope that it will of use to someone. I WILL NOT pay you any amount of money if anything happen to your data or you because of the changes this script makes nor am I obligated to help you fix issues this causes.
#

PATH="${PATH}:/usr/local/git/bin/"

INFO="${CONFIGURATION_BUILD_DIR}/${CONTENTS_FOLDER_PATH}/Info"
GITDIR="${PROJECT_DIR}/.git"

VERSION=`defaults read "${INFO}" CFBundleVersion`
if [ -d "${GITDIR}" ]; then
	REVISION=`git --git-dir="${GITDIR}" rev-parse --short HEAD`
	defaults write "${INFO}" CFBundleShortVersionString -string "${VERSION} (${REVISION})"
else
	defaults write "${INFO}" CFBundleShortVersionString -string "${VERSION}"
fi