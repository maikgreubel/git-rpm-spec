#!/bin/bash

if [ -z $1 ]; then
	echo "No version given"
	exit 1
fi

VERSION=$1
DEST=`pwd`/git-${VERSION}-bin

r=0

if [ ! -f git-${VERSION}.tar.xz ]; then
	wget -O git-${VERSION}.tar.xz https://www.kernel.org/pub/software/scm/git/git-${VERSION}.tar.xz
	r=$?
fi

if [ ${r} -ne 0 ]; then
	echo "Source not found!"
	exit 2
fi
rm -rfv git-${VERSION}
tar xf git-${VERSION}.tar.xz
if [ $? -ne 0 ]; then
	echo "Could not unpack source"
	exit 3
fi

cd git-${VERSION}
make configure
if [ $? -ne 0 ]; then
	echo "Could not create configure script"
	exit 4
fi

./configure --prefix=${DEST}
if [ $? -ne 0 ]; then
	echo "Could not configure git build"
	exit 5
fi

make && make install
if [ $? -ne 0 ]; then
	echo "Could not build or install git"
	exit 6
fi

exit 0
