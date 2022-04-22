#!/usr/bin/env bash

docker build -t docker_nvim .
docker run -it --rm docker_nvim:latest
