#!/usr/bin/env bash
set -e
# set -x
cd /tmp
ZLIB_ROOT="$PWD/zlib-1.2.13"
OPENSSL_ROOT="$PWD/openssl-3.1.0"
BOOST_ROOT="$PWD/boost_1_81_0"
[[ -d $ZLIB_ROOT ]] || curl -sL https://zlib.net/zlib-1.2.13.tar.gz | tar zxf - -C /tmp
[[ -d $OPENSSL_ROOT ]] || curl -sL https://www.openssl.org/source/openssl-3.1.0.tar.gz | tar zxf - -C /tmp
[[ -d $BOOST_ROOT ]] || curl -sL https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz | tar zxf -

target=( 
   arm-ctng-linux-musleabihf:linux-armv4:32
   armv7-ctng-linux-musleabihf:linux-armv4:32
   aarch64-ctng-linux-musl:linux-aarch64:64
   x86_64-ctng-linux-musl:linux-x86_64:64
)

for i in "${target[@]}";do
    IFS=':' read -ra t <<< "$i"
    PREFIX="/cross/${t[0]}"

    source "/toolchains/${t[0]}/env.sh"
    mkdir -p "/tmp/_build" && cd "/tmp/_build" && rm -rf *
    # build zlib
    CHOST=${t[0]} "$ZLIB_ROOT/configure" --static --prefix=$PREFIX
    make clean install

    # build openssl
    rm -rf /tmp/_build/*
    $OPENSSL_ROOT/Configure \
    ${t[1]} no-tests no-shared no-module \
    no-autoload-config no-deprecated \
    --cross-compile-prefix=${t[0]}- --prefix=$PREFIX
    make -j8
    make install_sw
    rm -rf "$PREFIX/{bin,share}"
    # build boost
    echo "using gcc :  : ${t[0]}-g++ ;" > /tmp/lb.jam
    cd $BOOST_ROOT
    [[ ! -f "./b2" ]] && ./bootstrap.sh
    ./b2 -a --user-config=/tmp/lb.jam --prefix="$PREFIX" \
    --with-system --with-program_options --with-json --with-serialization --with-log \
    cxxstd=20 link=static threading=multi runtime-link=shared \
    target-os=linux address-model=${t[2]} variant=release install
done

