#!/bin/bash
#
# Add PowerPC to Xcode4
#
# Created by Mr. Gecko <GRMrGecko@gmail.com> on 10/29/11.
# No Copyright Claimed. Public Domain.
#

#
# Before you continue, here is information on what it does so you understand exactly what can happen if you run this.
#
# This script will copy files from Xcode3 to Xcode4 possibly replacing existing files on Xcode4 with older files to add support for PowerPC. If this process fails, you will have to uninstall Xcode with "/Developer/Library/uninstall-devtools –mode=all" and reinstall it. You can do the same for Xcode3 if you kept it's files "/Xcode3/Library/uninstall-devtools –mode=all".
#
# DISCLAIMER: This script is provided as-is. I am not responsible if this script somehow causes harm to you or your system in any way, I am providing this for free in hope that it will of use to someone who has problems with needing PPC suppport in Xcode4 such as myself. I WILL NOT pay you any amount of money if anything happen to your data or you because of the changes this script makes nor am I obligated to help you fix issues this causes.
#
# Requirements:
# • A copy of Xcode 4 which can be downloaded from the App Store.
# • A copy of Xcode 3 which can be downloaded from http://connect.apple.com/.
#
# Installation of Xcode:
# Install Xcode 4 first unless you installed Xcode 3 as says below which you will have to inorder to run this script.
# Install Xcode 3 after Xcode 4 has been installed and follow instructions below for installation on Lion.
#
# To install Xcode 3 on Lion (10.7), you have to run the package from terminal due to checks. Run the following command in terminal.
# COMMAND_LINE_INSTALL=1 open /Volumes/Xcode\ and\ iOS\ SDK/Xcode\ and\ iOS\ SDK.mpkg
#
# Go through the steps until you get to the customization screen and do the following.
# 1. On location, choose /Xcode3 as that is what my script references (You can create a file in the open directory by cmd-shift-n).
# 2. System Tools, UNIX Development, and Documentation are optional.
# 3. If you want to compile using the 10.4u SDK, check "Mac OS X 10.4 SDK" and this script will determine rather or not it is installed and copy it over.
#
# Now that both Xcode 3 and Xcode 4 is installed, you can run this script in Terminal to add PPC support to Xcode.
#
# After you run this script, it's up to you if you want to delete /Xcode3 to save space. You can run the following terminal command to remove it.
# rm -Rf /Xcode3
#
# When you want PPC support in your application, be sure to add to Valid Architectures in the Xcode Project's build configuration "ppc" and add to Architectures "ppc" to compile PowerPC Code.

# Copy binaries of GCC from Xcode3
cd /Developer/usr/bin
cp /Xcode3/usr/bin/*4.0* .
cp /Xcode3/usr/bin/*4.2* .

# Copy PowerPC and Intel Binaries
mkdir -p /Developer/usr/libexec/gcc/powerpc-apple-darwin10
cd /Developer/usr/libexec/gcc/powerpc-apple-darwin10
cp -R /Xcode3/usr/libexec/gcc/powerpc-apple-darwin10/4.0.1 .
cp -R /Xcode3/usr/libexec/gcc/powerpc-apple-darwin10/4.2.1 .
mkdir -p /Developer/usr/libexec/gcc/i686-apple-darwin10
cd /Developer/usr/libexec/gcc/i686-apple-darwin10
cp -R /Xcode3/usr/libexec/gcc/i686-apple-darwin10/4.0.1 .
cp -R /Xcode3/usr/libexec/gcc/i686-apple-darwin10/4.2.1 .

# Add PPC support to LLVM GCC
cd /Developer/usr/llvm-gcc-4.2/bin
cp /Xcode3/usr/llvm-gcc-4.2/bin/powerpc-apple-darwin10-llvm-g++-4.2 .
cp /Xcode3/usr/llvm-gcc-4.2/bin/powerpc-apple-darwin10-llvm-gcc-4.2 .
cp /Xcode3/usr/llvm-gcc-4.2/bin/i686-apple-darwin10-llvm-g++-4.2 .
cp /Xcode3/usr/llvm-gcc-4.2/bin/i686-apple-darwin10-llvm-gcc-4.2 .
cd /Developer/usr/llvm-gcc-4.2/include/gcc/darwin/4.2
cp /Xcode3/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/ppc_intrinsics.h .
cp /Xcode3/usr/llvm-gcc-4.2/include/gcc/darwin/4.2/stdint.h .
cd /Developer/usr/llvm-gcc-4.2/lib/gcc
cp -R /Xcode3/usr/llvm-gcc-4.2/lib/gcc/powerpc-apple-darwin10 .
cp -R /Xcode3/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin10 .
cd /Developer/usr/llvm-gcc-4.2/libexec/gcc
cp -R /Xcode3/usr/llvm-gcc-4.2/libexec/gcc/powerpc-apple-darwin10 .
cp -R /Xcode3/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin10 .
cp -R /Xcode3/usr/llvm-gcc-4.2/libexec/gcc/libllvmgcc.dylib ./libllvmgcc.xc3.dylib
cd /Developer/usr/llvm-gcc-4.2/libexec/gcc/powerpc-apple-darwin10/4.2.1
rm libllvmgcc.dylib
ln -s ../../libllvmgcc.xc3.dylib ./libllvmgcc.dylib
cd /Developer/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin10/4.2.1
rm libllvmgcc.dylib
ln -s ../../libllvmgcc.xc3.dylib ./libllvmgcc.dylib

# Copy libraries
cd /Developer/usr/lib
cp -R /Xcode3/usr/lib/gcc .

# Copy Assemblers.
cd /Developer/usr/libexec/as
cp -R /Xcode3/usr/libexec/gcc/darwin/ppc .
cp -R /Xcode3/usr/libexec/gcc/darwin/ppc64 .

# Copy plugins for GCC
cd /Developer/Library/Xcode/PrivatePlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins
cp -R /Xcode3/Library/Xcode/Plug-ins/GCC\ 4.0.xcplugin .
cp -R /Xcode3/Library/Xcode/Plug-ins/GCC\ 4.2.xcplugin .

# Replace xcodebuild with xcodebuild in Xcode4
cd /usr/bin/
mv xcodebuild xcodebuild3
ln -s /Developer/usr/bin/xcodebuild .

# Copy over old SDKs.
cd /Developer/SDKs
if [ -d "/Xcode3/SDKs/MacOSX10.5.sdk" ]; then
	cp -R /Xcode3/SDKs/MacOSX10.5.sdk .
fi
if [ -d "/Xcode3/SDKs/MacOSX10.4u.sdk" ]; then
	cp -R /Xcode3/SDKs/MacOSX10.4u.sdk .
fi

# Delete SDKs folder in Xcode3 and symbolic link the one from Xcode4 as we do not need two copies of SDKs.
cd /Xcode3
rm -Rf SDKs
ln -s /Developer/SDKs .