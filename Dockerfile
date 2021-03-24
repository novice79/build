FROM ubuntu:20.04
LABEL maintainer="Novice <novice79@126.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  

COPY sources.list /etc/apt/sources.list
COPY ins_pack.sh /ins_pack.sh
RUN /ins_pack.sh

ENV LC_ALL en_US.UTF-8   

ENTRYPOINT ["bash"]
# docker build -t test .