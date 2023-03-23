#!/bin/bash

file_path="$1"

domain=$(jq -r '.domain' < "$file_path")
user_agent=$(jq -r '.userAgent' < "$file_path")
disallowed_paths=($(jq -r '.disallowedPaths[]' < "$file_path"))
allowed_paths=($(jq -r '.allowedPaths[]' < "$file_path"))

curl -s "https://$domain/robots.txt" > ./robots.txt

failures=0

for path in "${disallowed_paths[@]}"
do
    if ! ./c-build/robots ./robots.txt "$user_agent" "$path" | grep -q "DISALLOWED"; then
        echo "Expected: $path to be DISALLOWED, but was ALLOWED"
        ((failures++))
    fi
done

for path in "${allowed_paths[@]}"
do
    if ! ./c-build/robots ./robots.txt "$user_agent" "$path" | grep -v "DISALLOWED" | grep -q "ALLOWED"; then
        echo "Expected: $path to be ALLOWED, but was DISALLOWED"
        ((failures++))
    fi
done

if [[ "$failures" -gt 0 ]]; then
    echo "number of failed assertions: $failures"
    exit 1
else
    echo "all assertions passed"
    exit 0
fi
