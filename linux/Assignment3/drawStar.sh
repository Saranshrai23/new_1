#!/bin/bash

size=$1
type=$2

# check arguments
if [ $# -ne 2 ]; then
    echo "Usage: ./drawStar.sh <size> <type|all>"
    exit 1
fi

# function to print spaces
print_spaces() {
    for ((s=1; s<=$1; s++)); do
        echo -n " "
    done
}

# function to print stars
print_stars() {
    for ((s=1; s<=$1; s++)); do
        echo -n "*"
    done
}

# ALL patterns
if [ "$type" = "all" ]; then
    for t in t1 t2 t3 t4 t5 t6 t7
    do
        echo "===== Pattern $t ====="
        ./drawStar.sh "$size" "$t"
        echo
    done
    exit 0
fi

case $type in

t1)
    for ((i=1; i<=size; i++)); do
        print_spaces $((size-i))
        print_stars $i
        echo
    done
;;

t2)
    for ((i=1; i<=size; i++)); do
        print_stars $i
        echo
    done
;;

t3)
    for ((i=1; i<=size; i++)); do
        print_spaces $((size-i))
        print_stars $((2*i-1))
        echo
    done
;;

t4)
    for ((i=size; i>=1; i--)); do
        print_stars $i
        echo
    done
;;

t5)
    for ((i=size; i>=1; i--)); do
        print_spaces $((size-i))
        print_stars $i
        echo
    done
;;

t6)
    for ((i=size; i>=1; i--)); do
        print_spaces $((size-i))
        print_stars $((2*i-1))
        echo
    done
;;

t7)
    for ((i=1; i<=size; i++)); do
        print_spaces $((size-i))
        print_stars $((2*i-1))
        echo
    done
    for ((i=size-1; i>=1; i--)); do
        print_spaces $((size-i))
        print_stars $((2*i-1))
        echo
    done
;;

*)
    echo "Invalid type. Use t1 to t7 or all"
;;

esac
