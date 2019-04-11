FROM ubuntu:latest
LABEL maintainer="David <david@cninone.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ARG DEBIAN_FRONTEND=noninteractive
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  

COPY main.py /tmp/main.py
COPY ins_pack.sh /ins_pack.sh
RUN /ins_pack.sh

ENV LC_ALL en_US.UTF-8   
COPY kp /root/.ssh
ENTRYPOINT ["/init"]
