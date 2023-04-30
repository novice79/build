#!/usr/bin/env bash

cd /tmp
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - 
apt-get install -y nodejs p7zip-full
rm -rf *


rm -- "$0"