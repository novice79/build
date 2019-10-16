#!/bin/bash

cd /tmp
apt-get install -y libopenblas-dev liblapack-dev libx11-dev
wget http://dlib.net/files/dlib-19.18.tar.bz2
tar xvf dlib-19.18.tar.bz2
cd dlib-19.18/
mkdir build
cd build
# dynamic dll
# cmake -DBUILD_SHARED_LIBS=1 ..
# export CXXFLAGS="-fPIC"
cmake -D CMAKE_CXX_FLAGS="-fPIC" -DCMAKE_C_FLAGS="-fPIC" ..
cmake --build . --config Release
make install
# opencv begin
cd /tmp
apt-get install -y git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
cd opencv && mkdir build && cd build
cmake -D BUILD_EXAMPLES=OFF -D BUILD_opencv_apps=OFF -D BUILD_DOCS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF \
      -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=OFF ..
make -j4
make install
# opencv end
cd /tmp
npm i cmake-js node-gyp -g
rm -rf *


rm -- "$0"