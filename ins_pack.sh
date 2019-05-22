#!/bin/bash

apt-get update -y && apt-get install -y \
    wget curl gnupg locales tzdata software-properties-common unzip
     
locale-gen en_US.UTF-8 zh_CN.UTF-8 ; mkdir -p /data/workspace


TZ=Asia/Chongqing
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get update && apt-get install -y openjdk-11-jdk-headless

GRADLE=gradle-5.4.1-bin.zip
cd /tmp
wget "https://downloads.gradle.org/distributions/$GRADLE"
unzip -d /data/ $GRADLE 
export PATH="$PATH:/data/gradle-5.4.1/bin"
rm -rf *










rm -- "$0"