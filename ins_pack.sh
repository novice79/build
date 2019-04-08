#!/bin/bash

apt-get update -y && apt-get install -y \
    wget curl gnupg locales tzdata software-properties-common unzip upx
     
locale-gen en_US.UTF-8 zh_CN.UTF-8 ; mkdir -p /var/run/sshd

LANG=en_US.UTF-8
{ \
        echo "LANG=$LANG"; \
        echo "LANGUAGE=$LANG"; \
        echo "LC_ALL=$LANG"; \
} > /etc/default/locale
useradd -ms /bin/bash david && usermod -aG sudo david ; \
        echo 'david:freego' | chpasswd ; echo 'root:freego_2019' | chpasswd


TZ=Asia/Chongqing
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# php begin
add-apt-repository ppa:ondrej/php
# nodejs begin
curl -sL https://deb.nodesource.com/setup_11.x | bash - 

apt-get update && apt-get install -y nodejs build-essential g++ gcc-8 g++-8 python3-pip python-pip \
	php7.3 php7.3-bcmath php7.3-bz2 php7.3-cli php7.3-common php7.3-curl php7.3-dba php7.3-dev php7.3-enchant \
	php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-intl php7.3-json php7.3-mbstring php7.3-mysql php7.3-odbc \
	php7.3-opcache php7.3-pgsql php7.3-readline \
	php7.3-soap php7.3-sqlite3 php7.3-tidy php7.3-xml php7.3-xmlrpc php7.3-zip php-redis php-igbinary php-mongodb 

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

pip3 install sanic

curl -o /usr/local/bin/composer https://getcomposer.org/download/1.8.4/composer.phar && chmod +x /usr/local/bin/composer
npm install -g pkg
pip3 install pyinstaller
cd /tmp
pyinstaller -F main.py
echo "console.log('Hello world');" >  app.js
pkg -t node10-linux app.js
# retain python app for test?

wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2
tar jxf boost*.tar.bz2
cd boost_1_69_0 && ./bootstrap.sh
./b2 threading=multi threadapi=pthread link=static runtime-link=static install
cd ..
# rm -rf boost*
wget https://github.com/Kitware/CMake/releases/download/v3.14.1/cmake-3.14.1-Linux-x86_64.tar.gz
tar zxf cmake*.tar.gz
cd cmake-3.14.1-Linux-x86_64
cp -r bin /usr/
cp -r share /usr/
cp -r doc /usr/share/
cp -r man /usr/share/
cd ..
# rm -rf cmake-3.14.1-Linux-x86_64*
rm -rf *
rm -- "$0"