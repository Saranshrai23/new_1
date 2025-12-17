#!/bin/bash

action=$1
file=$2

case "$action" in

addLineTop)
    sed -i "1i $3" "$file"
    ;;

addLineBottom)
    echo "$3" >> "$file"
    ;;

addLineAt)
    sed -i "${3}i $4" "$file"
    ;;

updateFirstWord)
    sed -i "0,/$3/s//$4/" "$file"
    ;;

updateAllWords)
    sed -i "s/$3/$4/g" "$file"
    ;;

insertWord)
    sed -i "s/$3/$3 $4/" "$file"
    ;;

deleteLine)
    sed -i "${3}d" "$file"
    ;;

deleteLineWithWord)
    sed -i "/$3/d" "$file"
    ;;

*)
    echo "Invalid command"
    ;;
esac
