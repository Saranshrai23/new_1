#!/bin/bash

template_file=$1
content=$(cat "$template_file")

shift

for pair in "$@" #$@ = all remaining arguments
do
    key=${pair%%=*}
    value=${pair#*=}

    content=$(echo "$content" | sed "s/{{${key}}}/${value}/g")
done

echo "$content"
