# Overview

Packages up https://github.com/google/robotstxt into a docker container.

# Building

`docker build . -t robotstxt`

# Running

`docker run -v $(pwd):/data --rm robotstxt /data/validate.json`
