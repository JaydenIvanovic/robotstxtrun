# Overview

Packages up Googles Robots.txt Parser and Matcher Library (https://github.com/google/robotstxt) into a docker container, and adds a small bash wrapper to assert URLs are allowed or disallowed via a JSON object.

Useful for running assertions locally in a dev or CI environment to validate any changes to a robots.txt file.

# Building

`docker build . -t robotstxt`

# Running

`./robotstxtrun.sh /path/to/robotstxtrun.json`
