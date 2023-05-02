#!/usr/bin/env bash
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - 
apt-get install -y nodejs p7zip-full rsync

function buildAndCpLibs {
    ./linux_build.sh lib
    ./macos-build-on-linux.sh lib
    rsync -a dist/linux/armv7/ /cross/armv7-ctng-linux-musleabihf/
    rsync -a dist/linux/aarch64/ /cross/aarch64-ctng-linux-musl/
    rsync -a dist/linux/x86_64/ /cross/x86_64-ctng-linux-musl/

    rsync -a dist/macos-aarch64/ /cross/aarch64-apple-darwin21.4/
    rsync -a dist/macos-x86_64/ /cross/x86_64-apple-darwin21.4/
}
# build pyu lib begin
cd /tmp
git clone --depth=1 https://github.com/novice79/pyu.git
cd pyu
buildAndCpLibs

# build bhttp lib begin
cd /tmp
git clone --depth=1 -b pro https://github.com/novice79/bhttp.git
cd bhttp
buildAndCpLibs

# tree -L 3 /cross
rm -rf *

rm -- "$0"