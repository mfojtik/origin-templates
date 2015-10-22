#!/bin/sh

set -ex

IMAGE_NAME=${IMAGE_NAME:-mfojtik/origin-templates}
docker build -t ${IMAGE_NAME} .

base=$(awk '/^FROM/{print $2}' Dockerfile)
easy_install -q --user docker_py==1.2.3 docker-scripts==0.4.2
${HOME}/.local/bin/docker-scripts squash -f ${base} ${IMAGE_NAME}
