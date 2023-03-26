#!/usr/bin/env bash

os=$(cat /etc/os-release | grep "^ID=" | cut -d'=' -f2 | tr -d \")
if [[ $os == alpine ]];then
    # /etc/ld-musl-x86_64.path
    # apk update && apk add gcompat
    echo "apline linux not supported yet"
    exit 1
else 
    echo "$PWD/lib" > /etc/ld.so.conf.d/macos.conf
    ldconfig
fi
echo "PATH=$PWD/bin:$PATH" >> /etc/profile
. /etc/profile
arch=( 
    arm64
    x86_64
)
for i in "${arch[@]}";do
target="$i-apple-darwin21.4"
# IFS='-' read -ra t <<< "$target"
t=(${target//-/ })
# echo ${t[@]} 

BIN="$PWD/bin"
cat > "$PWD/$i-toolchain.cmake" <<-EOF
set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_PROCESSOR $i)

set(CMAKE_C_COMPILER \${CMAKE_CURRENT_LIST_DIR}/bin/${target}-cc)
set(CMAKE_CXX_COMPILER \${CMAKE_CURRENT_LIST_DIR}/bin/${target}-c++)
set(CMAKE_AR \${CMAKE_CURRENT_LIST_DIR}/bin/${target}-ar)
set(CMAKE_STRIP \${CMAKE_CURRENT_LIST_DIR}/bin/${target}-strip)


set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
EOF

cat > "$PWD/$i-meson_cross.txt" <<-EOF
[binaries]
c = '$BIN/${target}-cc'
cpp = '$BIN/${target}-c++'
ld = '$BIN/${target}-ld'
ar = '$BIN/${target}-ar'
strip = '$BIN/${target}-strip'

[host_machine]
system = 'Darwin'
cpu_family = '${t[0]}'
cpu = '${t[0]}'
endian = 'little'
EOF

cat > "$PWD/$i-env.sh" <<-EOF
CC="$BIN/${target}-cc"
CXX="$BIN/${target}-c++"
AR="$BIN/${target}-ar"
AS="$BIN/${target}-as"
STRIP="$BIN/${target}-strip"
LD="$BIN/${target}-ld"


HOST=$target
export PATH="$BIN:$PATH"
EOF

done