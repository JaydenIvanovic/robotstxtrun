# Overview

Packages up Googles Robots.txt Parser and Matcher Library (https://github.com/google/robotstxt) into a docker container, and adds a small bash wrapper to assert URLs are allowed or disallowed via a JSON object.

Useful for running assertions locally in a dev or CI environment to validate any changes to a robots.txt file.

# Building

`docker build . -t robotstxt`

# Running

`./robotstxtrun.sh /path/to/robotstxtrun.json`

# Example

Given a json file with the following config:

```json
{
  "domain": "example.org",
  "userAgent": "Googlebot",
  "disallowedPaths": ["/login"],
  "allowedPaths": ["/shop"]
}
```

and a `robots.txt` file:

```txt
User-agent: *
Disallow: /login$
```

will result in the following output:

```sh
all assertions passed
```

being printed to the console

Using the default configuration file in the repo, will result in the following output:

```
Expected: /this/should/be/disallowed to be DISALLOWED, but was ALLOWED
number of failed assertions: 1
```
