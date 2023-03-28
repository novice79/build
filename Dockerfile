FROM ubuntu:22.04
LABEL maintainer="Novice <novice79@126.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  

WORKDIR /toolchains
COPY ins_pack.sh /ins_pack.sh
COPY fix-location.sh /fix-location.sh
RUN /ins_pack.sh
COPY test ./test
ENV LC_ALL en_US.UTF-8   
COPY linux-prebuilt.sh .
RUN ./linux-prebuilt.sh
COPY macos-prebuilt.sh .
RUN ./macos-prebuilt.sh
RUN rm -rf /tmp/*
# ENTRYPOINT ["bash", "-l", "-c"]
CMD ["bash"]
# docker build -t test .