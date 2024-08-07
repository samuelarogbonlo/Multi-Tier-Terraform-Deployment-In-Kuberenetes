#!/bin/bash

set -e

DOCKER_IMAGE="localstack/localstack:2.3"
CONTAINER_NAME="camunda_localstack"

if [[ "$1" == "start" ]]; then
    echo "Pulling docker image $DOCKER_IMAGE..."
    docker pull "$DOCKER_IMAGE"
    # listening on 0.0.0.0 required for pods in the kind cluster to access localstack (host) on Linux
    # on Mac, host.docker.internal works like a charm
    echo "Starting Localstack in the background, as a Docker container"
    docker run --name "$CONTAINER_NAME" -p "0.0.0.0:4566:4566/tcp" -d "$DOCKER_IMAGE"

    echo "Waiting for Localstack to be ready"
    set +e
    CONTAINER_ID=$(docker ps -aqf "name=$CONTAINER_NAME")
    until [ "$(docker inspect -f {{.State.Health.Status}} $CONTAINER_ID)" == "healthy" ]; do
        echo -n "."
        sleep 3
    done
    set -e

elif [[ "$1" == "stop" ]]; then
    echo "Stopping Localstack docker container"
    docker stop "$CONTAINER_NAME"
    docker wait "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
fi
