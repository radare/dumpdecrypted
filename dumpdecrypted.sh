#!/bin/sh
# helper script for i0nic's dumpdecrypted by pancake
APPS=/var/mobile/Containers/Bundle/Application/
if [ -z "$1" ]; then
	cd $APPS
	ls -d */*.app | cut -d / -f 2- | sed -e 's,.app$,,'
else

	ls -l $APPS/*"/$1.app/$1"
	DYLD_INSERT_LIBRARIES=/usr/lib/dumpdecrypted.dylib $APPS/*"/$1.app/$1"
fi
