#!/bin/bash
APP_NAME="modsim"
APP_TAG="0.3.4"
PYTHON_TAG="3.8-slim-buster"

echo "$DOCKER_REGISTRY_PASSWORD" | docker login -u "$DOCKER_REGISTRY_USERNAME" --password-stdin "$DOCKER_REGISTRY"

export DOCKER_CLI_EXPERIMENTAL=enabled
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
# docker buildx create --name mybuilder
docker buildx use mybuilder

docker buildx build \
  --build-arg "APP_TAG=$APP_TAG" \
  --build-arg "PYTHON_TAG=$PYTHON_TAG" \
  --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --tag "$DOCKER_REGISTRY/$DOCKER_REGISTRY_USERNAME/$APP_NAME:$APP_TAG" \
  --tag "$DOCKER_REGISTRY/$DOCKER_REGISTRY_USERNAME/$APP_NAME:latest" \
  --push .
