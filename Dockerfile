FROM novice/build:latest
LABEL maintainer="Novice <novice@piaoyun.shop>"


COPY ins_pack.sh /ins_pack.sh
RUN /ins_pack.sh

# ENV LC_ALL en_US.UTF-8   

