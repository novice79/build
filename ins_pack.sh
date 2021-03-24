#!/bin/bash

apt-get update -y && apt-get install -y \
    wget curl gnupg locales tzdata apt-transport-https ca-certificates software-properties-common 

wget -O - \
https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
| gpg --dearmor - \
| tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main'

locale-gen en_US.UTF-8 zh_CN.UTF-8 ; mkdir -p /data/workspace

LANG=en_US.UTF-8
{ \
        echo "LANG=$LANG"; \
        echo "LANGUAGE=$LANG"; \
        echo "LC_ALL=$LANG"; \
} > /etc/default/locale

TZ=Asia/Chongqing
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# nodejs begin
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
# curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
# VERSION=node_14.x
# DISTRO="$(lsb_release -s -c)"
# echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list
# echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list

apt-get update && apt-get install -y \
nodejs build-essential \
gcc-10 g++-10 cmake \
zlib1g-dev libssl-dev libboost-all-dev \
libsqlite3-dev libmagic-dev

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9  9  --slave /usr/bin/g++ g++ /usr/bin/g++-9
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10 --slave /usr/bin/g++ g++ /usr/bin/g++-10

# rm -- "$0"