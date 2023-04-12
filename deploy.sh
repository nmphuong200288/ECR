#!/bin/bash
echo "Starting to deploy docker image.."
DOCKER_IMAGE=${IMAGE_REPO_NAME}:${IMAGE_TAG}
docker pull $DOCKER_IMAGE
docker ps -q --filter ancestor=$DOCKER_IMAGE | xargs -r docker stop
docker run -d -p 8080:8080 $DOCKER_IMAGE
