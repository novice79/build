# C++ cross build tools pack

- arm-ctng-linux-musleabihf
- armv7-ctng-linux-musleabihf
- aarch64-ctng-linux-musl
- x86_64-ctng-linux-musl
- apple-darwin21.4 (aarch64/x86_64 macos)


# Test six(4 linux, 2 macos) targets build

    docker run -it --rm --name cb novice/build
    cd test
    ./cmake-build-test.sh
    ./meson-build-test.sh

