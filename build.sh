#!/bin/sh
docker buildx create --name mybuilder --driver docker-container --bootstrap --use
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t novice/build:alpine --push .