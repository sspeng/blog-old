#!/bin/bash

container_id=`docker ps | grep 'conghui/jekyll' | awk '{print $1}'`
docker stop $container_id && \
docker rm $container_id && \
./deploy.sh
