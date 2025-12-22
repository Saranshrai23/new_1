#!/bin/bash

action=$1
file=$2

if [ ! -f "$file" ]; then
    echo "File not found!"
    exit 1
fi

case $action in

addLineTop)
    line="$3"
    sed -i "1i $line" "$file"
    ;;

addLineBottom)
    line="$3"
    echo "$line" >> "$file"
    ;;

addLineAt)
    lineno="$3"
    line="$4"
    sed -i "${lineno}i $line" "$file"
    ;;

updateFirstWord)
    word1="$3"
    word2="$4"
    sed -i "0,/$word1/s//$word2/" "$file"
    ;;

updateAllWords)
    word1="$3"
    word2="$4"
    sed -i "s/$word1/$word2/g" "$file"
    ;;

deleteLine)
    lineno="$3"
    word="$4"
    if [ -z "$word" ]; then
        sed -i "${lineno}d" "$file"
    else
        sed -i "${lineno}/$word/d" "$file"
    fi
    ;;

*)
    echo "Invalid command"
    ;;

esac
