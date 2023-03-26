#!/usr/bin/env bash

set -e 

dir=_build
function build {
    [ -f "$1" ] && echo "use cmake toolchain file: $1" || return 1
    rm -rf "$dir"
    cmake -H"src" -B"$dir" \
    -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE=$1 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$2"

    cmake --build $dir --config Release
    cmake --install $dir

    ls -lh $2
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color
    printf "${GREEN}"
    file $2/main*
    printf "${NC}"
}
target=( 
    arm-ctng-linux-musleabihf
    armv7-ctng-linux-musleabihf
    aarch64-ctng-linux-musl
    x86_64-ctng-linux-musl
)
for i in "${target[@]}";do
    tcf="/toolchains/$i/toolchain.cmake"
    PREFIX="dist/$i"
    build $tcf $PREFIX
done

target=( 
    aarch64
    x86_64
)
for i in "${target[@]}";do
    tcf="/toolchains/apple-darwin21.4/$i-toolchain.cmake"
    PREFIX="$PWD/dist/macos-$i"
    build $tcf $PREFIX
done