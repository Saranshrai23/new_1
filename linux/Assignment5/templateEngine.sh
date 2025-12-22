#!/bin/bash

template_file=$1
shift  # remove first argument so $@ contains key=value pairs

if [ ! -f "$template_file" ]; then
    echo "Template file not found!"
    exit 1
fi

# read template into a variable
content=$(cat "$template_file")

# replace each key=value pair
for kv in "$@"; do
    key=$(echo $kv | cut -d= -f1)
    value=$(echo $kv | cut -d= -f2)
    content=$(echo "$content" | sed "s/{{${key}}}/$value/g")
done

echo "$content"
