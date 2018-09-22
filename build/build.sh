#!/bin/bash

set -e

BUILD_DIR=$(cd $(dirname "$0"); pwd)
VERSION=$(cat VERSION)
REGISTRY="registry.thuault.com"
IMAGE="clement/website/speed-dial"

sudo docker build -t $REGISTRY/$IMAGE:$VERSION -t $REGISTRY/$IMAGE:latest .

sudo docker push $REGISTRY/$IMAGE:$VERSION
sudo docker push $REGISTRY/$IMAGE:latest
