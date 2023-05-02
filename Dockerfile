FROM alpine:latest
LABEL maintainer="Novice <novice79@126.com>"
# RUN sed -i 's@dl-cdn.alpinelinux.org@mirrors.ustc.edu.cn@g' /etc/apk/repositories
# boost-dev boost-static \
RUN apk update \
	&& apk add linux-headers \
	openssl-dev openssl-libs-static \
	zlib-dev bzip2-dev icu-dev \
	nftables-dev gmp-dev \
	zlib-static bzip2-static icu-static \
	nftables-static libmnl-static libnftnl-dev \
	git curl make gcc g++ ninja cmake 
RUN cd /tmp \
	&& curl -OL https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.bz2 \
	&& tar jxvf jansson-2.14.tar.bz2 && cd jansson* \
	&& ./configure --enable-shared=no && make install \
	&& cd /tmp \
	&& curl -OL https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz \
	&& tar zxf boost_1_82_0.tar.gz && cd boost_1_82_0 && bootstrap.sh \
	&& ./b2 cxxstd=20 variant=release link=static threading=multi install \
    && cd /tmp && rm -rf *
WORKDIR /workspace

CMD ["sh"]
# docker build -t novice/build:alpine .
# docker push novice/build:alpine
# docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t novice/build:alpine --push .