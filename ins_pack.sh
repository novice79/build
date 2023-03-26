#!/usr/bin/env bash

apt-get update -y && apt-get install -y \
    wget curl git gnupg locales tzdata file \
    apt-transport-https ca-certificates \
    software-properties-common sudo xz-utils

locale-gen en_US.UTF-8 zh_CN.UTF-8 
LANG=en_US.UTF-8
{ \
    echo "LANG=$LANG"; \
    echo "LANGUAGE=$LANG"; \
    echo "LC_ALL=$LANG"; \
} > /etc/default/locale
useradd -ms /bin/bash novice && usermod -aG sudo novice ; \
        echo 'novice:freego' | chpasswd ; echo 'root:freego_2023' | chpasswd
echo "novice   ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nv
wget -O - \
https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
| gpg --dearmor - \
| tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -s -c) main"

TZ=Asia/Chongqing
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get update \
&& apt-get install -y \
clang \
cmake \
ninja-build \
meson
tcs=(
    https://github.com/novice79/homebrew-gcc-cross/releases/download/v1.0.0/arm-ctng-linux-musleabihf-x86_64-linux.tar.xz
    https://github.com/novice79/homebrew-gcc-cross/releases/download/v1.0.0/armv7-ctng-linux-musleabihf-x86_64-linux.tar.xz
    https://github.com/novice79/homebrew-gcc-cross/releases/download/v1.0.0/aarch64-ctng-linux-musl-x86_64-linux.tar.xz
    https://github.com/novice79/homebrew-gcc-cross/releases/download/v1.0.0/x86_64-ctng-linux-musl-x86_64-linux.tar.xz
    https://github.com/novice79/build/releases/download/v1.0.0/apple-darwin21.4.tar.xz
)
for i in "${tcs[@]}";do
    curl -sL $i | tar Jxf -
done
curl -OL https://raw.githubusercontent.com/novice79/homebrew-gcc-cross/master/init.sh
for i in *ctng*/;do
    cp init.sh $i
    cd $i 
    chmod +x ./init.sh && ./init.sh && rm ./init.sh
    cd ..
done
rm ./init.sh
cd apple-darwin21.4 && ./fix-location.sh && cd ..
for i in */;do
    ln -s $PWD/${i}bin/* /usr/local/bin/
done
# cd /tmp
# boost_ver=1_81_0
# wget "https://dl.bintray.com/boostorg/release/${boost_ver//_/.}/source/boost_$boost_ver.tar.bz2"
# tar jxf boost_$boost_ver.tar.bz2
# # can not cd *xx*xx*
# cd boost_$boost_ver && ./bootstrap.sh
# ./b2 cxxflags=-fPIC link=static runtime-link=shared threading=multi threadapi=pthread install
# cd /tmp
# lt_ver="2.0.2"
# wget https://github.com/arvidn/libtorrent/releases/download/v$lt_ver/libtorrent-rasterbar-$lt_ver.tar.gz
# tar zxf libtorrent-rasterbar-$lt_ver.tar.gz
# echo "using gcc ;" > /tmp/user-config.jam
# export BOOST_ROOT="/tmp/boost_$boost_ver"
# export BOOST_BUILD_PATH=$BOOST_ROOT/tools/build
# export PATH="$BOOST_ROOT:$PATH"
# cd libtorrent-rasterbar-$lt_ver
# # cxxstd=20 build failed
# b2 -j4 --user-config=/tmp/user-config.jam \
# crypto=openssl cxxstd=20 \
# variant=release target-os=linux \
# boost-link=static logging=off dht=on \
# threading=multi threadapi=pthread link=static runtime-link=shared \
# install

# cd /tmp
# rm -rf *

# rm -- "$0"