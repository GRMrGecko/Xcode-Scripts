#!/bin/bash
#
# Build Directory
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 4/21/11.
# No Copyright Claimed. Public Domain.
#
# DISCLAIMER: This script is provided as-is. I am not responsible if this script somehow causes harm to you or your system in any way, I am providing this for free in hope that it will of use to someone. I WILL NOT pay you any amount of money if anything happen to your data or you because of the changes this script makes nor am I obligated to help you fix issues this causes.
#

if [ "$SRCROOT/build" != "$SYMROOT" ]; then
	if [ -d "$SRCROOT/build" ]; then
		/bin/rm -Rf "$SRCROOT/build"
	fi
	/bin/ln -fs "$SYMROOT" "$SRCROOT/build"
fi