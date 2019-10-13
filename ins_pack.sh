#!/bin/bash


cd /vcpkg

./vcpkg install dlib:x64-linux opencv:x64-linux 
# CMake projects should use: "-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake"

rm -- "$0"