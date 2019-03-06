FROM ubuntu:latest
LABEL maintainer="David <david@cninone.com>"

# Get noninteractive frontend for Debian to avoid some problems:
#    debconf: unable to initialize frontend: Dialog
ENV DEBIAN_FRONTEND noninteractive

COPY ins_pack.sh /ins_pack.sh
RUN /ins_pack.sh


# ENTRYPOINT ["/init.sh"]
