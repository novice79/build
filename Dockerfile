FROM alpine:latest
LABEL maintainer="Novice <novice79@126.com>"
RUN sed -i 's@dl-cdn.alpinelinux.org@mirrors.ustc.edu.cn@g' /etc/apk/repositories \
	&& apk update \
	&& apk add linux-headers \
	openssl-dev boost-dev \
	openssl-libs-static boost-static \
	zlib-dev bzip2-dev zstd-dev icu-dev \
	nftables-dev gmp-dev \
	zlib-static bzip2-static zstd-static icu-static \
	nftables-static libmnl-static libnftnl-dev \
	git curl make gcc g++ ninja cmake 
RUN cd /tmp \
	&& curl -OL https://github.com/akheron/jansson/releases/download/v2.14/jansson-2.14.tar.bz2 \
	&& tar jxvf jansson-2.14.tar.bz2 && cd jansson* \
	&& ./configure --enable-shared=no && make install \
    && rm -rf *
WORKDIR /workspace

CMD ["sh"]
# docker build -t novice/build:alpine .
# docker push novice/build:alpine