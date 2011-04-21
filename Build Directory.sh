#!/bin/bash
#
# Build Directory
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 4/21/11.
# No Copyright Claimed. Public Domain.
#

if [ "$SRCROOT/build" != "$SYMROOT" ]; then
	if [ -d "$SRCROOT/build" ]; then
		/bin/rm -Rf "$SRCROOT/build"
	fi
	/bin/ln -fs "$SYMROOT" "$SRCROOT/build"
fi