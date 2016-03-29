#!/bin/bash
set -x

docker run -it --rm \
           --volume=$(pwd):/srv/jekyll \
           -w /srv/jekyll \
           -p 80:4000 \
           jekyll-3.0 \
           jekyll serve -w -I -H 0.0.0.0
