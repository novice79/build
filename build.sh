#!/bin/sh
docker buildx create --name mybuilder --driver docker-container --bootstrap --use
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t novice/build:alpine --push .

# docker buildx imagetools inspect novice/build:alpine
# docker pull --platform linux/arm/v7 novice/build:alpine
# docker run --platform linux/arm/v7 -it --rm --name tt novice/build:alpine