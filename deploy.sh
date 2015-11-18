#!/bin/bash
set -x

docker run -it \
           --volume=$(pwd):/srv/jekyll \
           -w /srv/jekyll \
           -d \
           -p 80:4000 \
           conghui/jekyll:v1 \
           jekyll serve -w -H 0.0.0.0
