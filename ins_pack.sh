#!/bin/bash


cd /vcpkg

./vcpkg install dlib:x64-linux opencv:x64-linux 
# CMake projects should use: "-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake"
# base image already: npm install -g cmake-js pkg 
npm install -g node-gyp
cd /tmp
echo "console.log('Hello world');" >  app.js
pkg -t node12-linux app.js
rm *

rm -- "$0"