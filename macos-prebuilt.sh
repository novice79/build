#!/usr/bin/env bash
set -e
# set -x
cd /tmp
ZLIB_ROOT="/tmp/zlib-1.2.13"
OPENSSL_ROOT="/tmp/openssl-3.1.0"
BOOST_ROOT="/tmp/boost_1_81_0"
[[ -d $ZLIB_ROOT ]] || curl -sL https://zlib.net/zlib-1.2.13.tar.gz | tar zxf - -C /tmp
[[ -d $OPENSSL_ROOT ]] || curl -sL https://www.openssl.org/source/openssl-3.1.0.tar.gz | tar zxf - -C /tmp
[[ -d $BOOST_ROOT ]] || curl -sL https://boostorg.jfrog.io/artifactory/main/release/1.81.0/source/boost_1_81_0.tar.gz | tar zxf -

target=( 
    aarch64:darwin64-arm64
    x86_64:darwin64-x86_64
)

for i in "${target[@]}";do
    IFS=':' read -ra t <<< "$i"
    PREFIX="/cross/${t[0]}-apple-darwin21.4"
    source "/toolchains/apple-darwin21.4/${t[0]}-env.sh"
    mkdir -p "/tmp/_build" && cd "/tmp/_build"
    # build zlib
    [[ -f $ZLIB_ROOT/configure.bak ]] && mv -v $ZLIB_ROOT/configure{.bak,}
    sed -i.bak "s#/usr/bin/libtool#${t[0]}-apple-darwin21.4-libtool#g" $ZLIB_ROOT/configure
    CHOST="${t[0]}-apple-darwin21.4" "$ZLIB_ROOT/configure" --static --prefix=$PREFIX
    make clean install

    # build openssl
    rm -rf /tmp/_build/*
    $OPENSSL_ROOT/Configure \
    ${t[1]} no-tests no-shared \
    no-autoload-config no-deprecated \
    --cross-compile-prefix=${t[0]}-apple-darwin21.4- --prefix=$PREFIX
    # perl _build/configdata.pm --dump
    make -j8
    make install_sw

    # build boost
    echo "using gcc :  : ${t[0]}-apple-darwin21.4-clang++ ;" > /tmp/lb.jam
    cd $BOOST_ROOT
    [[ ! -f "./b2" ]] && ./bootstrap.sh
    ./b2 -a --user-config=/tmp/lb.jam --prefix="$PREFIX" \
    --with-system --with-program_options --with-json --with-serialization --with-log \
    cxxstd=20 link=static threading=multi runtime-link=shared \
    target-os=darwin address-model=64 variant=release install
done

