#!/bin/bash
#
# Add PowerPC to Xcode4.5
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 9/22/12.
# No Copyright Claimed. Public Domain.
#

#
# Before you continue, here is information on what it does so you understand exactly what can happen if you run this.
#
# This script will copy files from Xcode3 to Xcode4 possibly replacing existing files on Xcode4 with older files to add support for PowerPC. If this process fails, you will have to uninstall Xcode with "/Developer/Library/uninstall-devtools –mode=all" and reinstall it. You can do the same for Xcode3 if you kept it's files "/Xcode3/Library/uninstall-devtools –mode=all".
#
# DISCLAIMER: This script is provided as-is. I am not responsible if this script somehow causes harm to you or your system in any way, I am providing this for free in hope that it will of use to someone who has problems with needing PPC suppport in Xcode4 such as myself. I WILL NOT pay you any amount of money if anything happen to your data or you because of the changes this script makes nor am I obligated to help you fix issues this causes.
#

XCODE3PACKAGES="/Volumes/Xcode and iOS SDK/Packages"
INSTALLDRIVEFILE="/tmp/235192GECKO.sparseimage"
INSTALLDRIVE="/Volumes/235192GECKO"
XCODEPATH="/Applications/Xcode.app/Contents"

if [ "$1" = "installroot" ]; then
	echo "Creating temporary install drive."
	hdiutil create -size 2g -type SPARSE -fs HFS+ -volname "235192GECKO" $INSTALLDRIVEFILE
	
	echo "Mounting Install Drive."
	hdiutil mount $INSTALLDRIVEFILE
	
	echo "Installing required packages to the Install Drive."
	installer -pkg "$XCODE3PACKAGES/gcc4.2.pkg" -target $INSTALLDRIVE
	installer -pkg "$XCODE3PACKAGES/llvm-gcc4.2.pkg" -target $INSTALLDRIVE
	installer -pkg "$XCODE3PACKAGES/MacOSX10.4.Universal.pkg" -target $INSTALLDRIVE
	installer -pkg "$XCODE3PACKAGES/MacOSX10.5.pkg" -target $INSTALLDRIVE
	installer -pkg "$XCODE3PACKAGES/DeveloperToolsCLI.pkg" -target $INSTALLDRIVE
	installer -pkg "$XCODE3PACKAGES/DeveloperTools.pkg" -target $INSTALLDRIVE
	
	echo "Adding GCC 4.2."
	cd "$XCODEPATH/Developer/usr/bin/"
	mv ld ld.original
	mv gcov-4.2 gcov-4.2.original
	mv llvm-cpp-4.2 llvm-cpp-4.2.original
	mv llvm-g++-4.2 llvm-g++-4.2.original
	mv llvm-gcc-4.2 llvm-gcc-4.2.original
	
	cp "$INSTALLDRIVE/usr/bin/ld" .
	cp "$INSTALLDRIVE/usr/bin/c++-4.2" .
	cp "$INSTALLDRIVE/usr/bin/cpp-4.2" .
	cp "$INSTALLDRIVE/usr/bin/g++-4.2" .
	cp "$INSTALLDRIVE/usr/bin/gcc-4.2" .
	cp "$INSTALLDRIVE/usr/bin/gcov-4.2" .
	cp "$INSTALLDRIVE/usr/bin/i686-apple-darwin10-cpp-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/i686-apple-darwin10-g++-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/i686-apple-darwin10-gcc-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/i686-apple-darwin10-llvm-g++-4.2" .
	cp "$INSTALLDRIVE/usr/bin/i686-apple-darwin10-llvm-gcc-4.2" .
	cp "$INSTALLDRIVE/usr/bin/llvm-cpp-4.2" .
	cp "$INSTALLDRIVE/usr/bin/llvm-g++-4.2" .
	cp "$INSTALLDRIVE/usr/bin/llvm-gcc-4.2" .
	cp "$INSTALLDRIVE/usr/bin/powerpc-apple-darwin10-cpp-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/powerpc-apple-darwin10-g++-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/powerpc-apple-darwin10-gcc-4.2.1" .
	cp "$INSTALLDRIVE/usr/bin/powerpc-apple-darwin10-llvm-g++-4.2" .
	cp "$INSTALLDRIVE/usr/bin/powerpc-apple-darwin10-llvm-gcc-4.2" .
	cp "$INSTALLDRIVE/usr/bin/as" .
	cp -R "$INSTALLDRIVE/usr/libexec/gcc" "$XCODEPATH/Developer/usr/libexec/"
	cp -R "$INSTALLDRIVE/usr/lib/gcc" "$XCODEPATH/Developer/usr/lib/"
	
	echo "Adding PowerPC support to LLVM."
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/bin/"
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/bin/i686-apple-darwin10-llvm-g++-4.2" .
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/bin/i686-apple-darwin10-llvm-gcc-4.2" .
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/bin/powerpc-apple-darwin10-llvm-g++-4.2" .
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/bin/powerpc-apple-darwin10-llvm-gcc-4.2" .
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/"
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/ppc_intrinsics.h" .
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/stdint.h" .
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/lib/gcc/"
	cp -R "$INSTALLDRIVE/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin10" .
	cp -R "$INSTALLDRIVE/usr/llvm-gcc-4.2/lib/gcc/powerpc-apple-darwin10" .
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/libexec/gcc/"
	cp -R "$INSTALLDRIVE/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin10" .
	cp -R "$INSTALLDRIVE/usr/llvm-gcc-4.2/libexec/gcc/powerpc-apple-darwin10" .
	cp "$INSTALLDRIVE/usr/llvm-gcc-4.2/libexec/gcc/libllvmgcc.dylib" ./libllvmgcc.xc3.dylib
	cd i686-apple-darwin10/4.2.1/
	rm libllvmgcc.dylib
	ln -s ../../libllvmgcc.xc3.dylib ./libllvmgcc.dylib
	cd ../../powerpc-apple-darwin10/4.2.1/
	rm libllvmgcc.dylib
	ln -s ../../libllvmgcc.xc3.dylib ./libllvmgcc.dylib
	
	echo "Adding Plugins."
	cd "$XCODEPATH/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins/"
	mv "GCC 4.2.xcplugin" "GCC 4.2.xcplugin.original"
	mv "LLVM GCC 4.2.xcplugin" "LLVM GCC 4.2.xcplugin.original"
	
	cp -R "$INSTALLDRIVE/Library/Xcode/Plug-ins/GCC 4.0.xcplugin" .
	cp -R "$INSTALLDRIVE/Library/Xcode/Plug-ins/GCC 4.2.xcplugin" .
	cp -R "$INSTALLDRIVE/Library/Xcode/Plug-ins/LLVM GCC 4.2.xcplugin" .
	
	echo "Adding 10.5 and 10.4 Universal SDKs for PowerPC compiling."
	cd "$XCODEPATH/Developer/Platforms/MacOSX.platform/Developer/SDKs/"
	cp -R "$INSTALLDRIVE/SDKs/MacOSX10.4u.sdk" .
	cp -R "$INSTALLDRIVE/SDKs/MacOSX10.5.sdk" .
	
	hdiutil unmount $INSTALLDRIVE
	rm $INSTALLDRIVEFILE
	
	echo "Installed."
	echo "Notes: If you wish to compile for PPC, you must add PPC to the \"Valid Archetecutes\" list and to the \"Archetecutes\" list. A normal configureation would be \"ppc i386 x86_64\"."
	echo "If you wish to compile for PPC using terminal. You should at least understand the basics of UNIX and know how to link $XCODEPATH/Developer/usr/bin/gcc-4.2 to /usr/bin/gcc-4.2. I am just providing you with paths so you know what to look for."
	exit
fi

if [ "$1" = "uninstallroot" ]; then
	echo "Removing GCC 4.2."
	cd "$XCODEPATH/Developer/usr/bin/"
	rm "ld"
	rm "c++-4.2"
	rm "cpp-4.2"
	rm "g++-4.2"
	rm "gcc-4.2"
	rm "gcov-4.2"
	rm "i686-apple-darwin10-cpp-4.2.1"
	rm "i686-apple-darwin10-g++-4.2.1"
	rm "i686-apple-darwin10-gcc-4.2.1"
	rm "i686-apple-darwin10-llvm-g++-4.2"
	rm "i686-apple-darwin10-llvm-gcc-4.2"
	rm "llvm-cpp-4.2"
	rm "llvm-g++-4.2"
	rm "llvm-gcc-4.2"
	rm "powerpc-apple-darwin10-cpp-4.2.1"
	rm "powerpc-apple-darwin10-g++-4.2.1"
	rm "powerpc-apple-darwin10-gcc-4.2.1"
	rm "powerpc-apple-darwin10-llvm-g++-4.2"
	rm "powerpc-apple-darwin10-llvm-gcc-4.2"
	rm "as"
	
	mv ld.original ld
	mv gcov-4.2.original gcov-4.2
	mv llvm-cpp-4.2.original llvm-cpp-4.2
	mv llvm-g++-4.2.original llvm-g++-4.2
	mv llvm-gcc-4.2.original llvm-gcc-4.2

	rm -R "$XCODEPATH/Developer/usr/libexec/gcc"
	rm -R "$XCODEPATH/Developer/usr/lib/gcc"
	
	echo "Removing PowerPC support to LLVM."
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/bin/"
	rm "i686-apple-darwin10-llvm-g++-4.2"
	rm "i686-apple-darwin10-llvm-gcc-4.2"
	rm "powerpc-apple-darwin10-llvm-g++-4.2"
	rm "powerpc-apple-darwin10-llvm-gcc-4.2"
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/"
	rm "ppc_intrinsics.h"
	rm "stdint.h"
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/lib/gcc/"
	rm -R "i686-apple-darwin10"
	rm -R "powerpc-apple-darwin10"
	cd "$XCODEPATH/Developer/usr/llvm-gcc-4.2/libexec/gcc/"
	rm -R "i686-apple-darwin10"
	rm -R "powerpc-apple-darwin10"
	rm libllvmgcc.xc3.dylib
	
	echo "Removing Plugins."
	cd "$XCODEPATH/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins/"
	rm -R "GCC 4.0.xcplugin"
	rm -R "GCC 4.2.xcplugin"
	rm -R "LLVM GCC 4.2.xcplugin"
	mv "GCC 4.2.xcplugin.original" "GCC 4.2.xcplugin"
	mv "LLVM GCC 4.2.xcplugin.original" "LLVM GCC 4.2.xcplugin"
	
	echo "Removing 10.5 and 10.4 Universal SDKs for PowerPC compiling."
	cd "$XCODEPATH/Developer/Platforms/MacOSX.platform/Developer/SDKs/"
	rm -R "MacOSX10.4u.sdk"
	rm -R "MacOSX10.5.sdk"
	exit
fi

echo "1. Install"
echo "2. Uninstall"
echo -n "What do you want to do: "
read PROCESS

if [ "$PROCESS" = "1" ]; then
	INSTALLED=0
	if [[ $(ls /Applications/ | grep "Xcode.app" 2> /dev/null) ]]; then
		INSTALLED=1
	fi
	if [ $INSTALLED -eq 0 ]; then
		echo "Xcode does not appear to be installed. Please install Xcode via the App Store."
		exit
	fi
	
	MOUNTED=0
	if [[ $(ls /Volumes/ | grep "Xcode and iOS SDK" 2> /dev/null) ]]; then
		MOUNTED=1
	fi
	if [ $MOUNTED -eq 0 ]; then
		echo "You must first mount the install drive \"xcode_3.2.6_and_ios_sdk_4.3__final.dmg\" which is avialable at http://connect.apple.com/ (search for \"Xcode 3.2.6\")."
		exit
	fi
	
	echo "If requested, enter your password to gain access to install nessisary files."
	sudo "$0" installroot
fi
if [ "$PROCESS" = "2" ]; then
	echo "If requested, enter your password to gain access to remove files."
	sudo "$0" uninstallroot
fi