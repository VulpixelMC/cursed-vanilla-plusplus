#!/bin/bash
VERSION=0.1.0
NAME="Cursed Vanilla++"

# clean old files
if [ -f ".build/$NAME $VERSION.zip" ]; then
    rm ".build/$NAME $VERSION.zip"
fi

if [ -f ".tmp" ]; then
	rm -rf .tmp
fi

# make .build directory
if [ ! -f ".build" ]; then
	mkdir .build
fi

# make .tmp directory
mkdir .tmp

# copy build files
if [ ! -f ".tmp/LICENSE" ]; then
	cp LICENSE .tmp
fi

if [ ! -f ".tmp/README.md" ]; then
	cp README.md .tmp
fi

cp -r shaders .tmp

cd .tmp

# zip shader
zip "../.build/$NAME $VERSION.zip" -r *

cd ..

# clean .tmp dir
rm -rf .tmp
