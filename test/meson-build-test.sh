#!/usr/bin/env bash

set -e
dir=_build
function build {
    [ -f "$1" ] && echo "use meson cross file: $1" || return 1
    rm -rf "$dir"
    meson setup $dir src \
    --prefix $2 \
    --cross-file $mcf \
    --buildtype release
    meson compile -C $dir
    meson install -C $dir

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
    mcf="/toolchains/$i/meson_cross.txt"
    PREFIX="$PWD/dist/$i"
    build $mcf $PREFIX
done

target=( 
    aarch64
    x86_64
)
for i in "${target[@]}";do
    mcf="/toolchains/apple-darwin21.4/$i-meson_cross.txt"
    PREFIX="$PWD/dist/macos-$i"
    build $mcf $PREFIX
done

