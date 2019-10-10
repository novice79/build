#!/bin/bash

apt-get update -y && apt-get install -y git wget curl unzip
     
mkdir -p /data/workspace

apt-get update && apt-get install -y build-essential g++ gcc-8 g++-8 libxxf86vm-dev
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
cd / && git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install
./vcpkg install boost:x64-linux dlib:x64-linux opencv:x64-linux
# CMake projects should use: "-DCMAKE_TOOLCHAIN_FILE=/vcpkg/scripts/buildsystems/vcpkg.cmake"

curl -sL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs
npm install -g cmake-js pkg

cd /tmp
wget https://github.com/Kitware/CMake/releases/download/v3.15.4/cmake-3.15.4-Linux-x86_64.tar.gz
tar zxf cmake*.tar.gz
cd cmake-*-Linux-x86_64
cp -r bin /usr/
cp -r share /usr/
cp -r doc /usr/share/
cp -r man /usr/share/
rm -rf *
cd ..

rm -- "$0"