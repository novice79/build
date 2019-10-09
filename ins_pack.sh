#!/bin/bash

apt-get update -y && apt-get install -y \
    git wget curl gnupg locales tzdata software-properties-common unzip upx
     
locale-gen en_US.UTF-8 zh_CN.UTF-8 ; mkdir -p /data/workspace

LANG=en_US.UTF-8
{ \
        echo "LANG=$LANG"; \
        echo "LANGUAGE=$LANG"; \
        echo "LC_ALL=$LANG"; \
} > /etc/default/locale

TZ=Asia/Chongqing
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get update && apt-get install -y build-essential g++ gcc-8 g++-8
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8
cd / && git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install

cd /tmp

wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
tar zxf cmake*.tar.gz
cd cmake-3.14.1-Linux-x86_64
cp -r bin /usr/
cp -r share /usr/
cp -r doc /usr/share/
cp -r man /usr/share/
cd ..

rm -rf *
rm -- "$0"