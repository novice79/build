#!/usr/bin/env bash

cd /tmp
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - 
apt-get install -y nodejs p7zip-full rsync
git clone --depth=1 https://github.com/novice79/pyu.git
cd pyu
workDir=$PWD
./linux_build.sh lib
# tree -L 2 /cross/aarch64-ctng-linux-musl/
rsync -a dist/linux/armv7/ /cross/armv7-ctng-linux-musleabihf/
rsync -a dist/linux/aarch64/ /cross/aarch64-ctng-linux-musl/
rsync -a dist/linux/x86_64/ /cross/x86_64-ctng-linux-musl/
# try to build macos version failed
# cd src/file
# ...
# make distclean
rm -rf *


rm -- "$0"