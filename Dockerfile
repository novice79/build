FROM novice/build:cross
LABEL maintainer="Novice <novice79@126.com>"


COPY ins_pack.sh /ins_pack.sh
RUN /ins_pack.sh

ENTRYPOINT ["/bin/bash"]
# ENV LC_ALL en_US.UTF-8   

