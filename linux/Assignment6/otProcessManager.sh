#!/bin/bash

action=$1
arg1=$2
arg2=$3

case $action in

topProcess)
    n=$arg1
    field=$arg2
    if [ "$field" = "memory" ]; then
        ps -eo pid,comm,%mem --sort=-%mem | head -n $((n+1))
    elif [ "$field" = "cpu" ]; then
        ps -eo pid,comm,%cpu --sort=-%cpu | head -n $((n+1))
    else
        echo "Use memory or cpu"
    fi
    ;;

killLeastPriorityProcess)
    pid=$(ps -eo pid,ni --sort=ni | head -n 2 | tail -n 1 | awk '{print $1}')
    kill -9 $pid
    echo "Killed process with PID $pid having least priority"
    ;;

RunningDurationProcess)
    pid_or_name=$arg1
    pid=$(ps -e -o pid,comm | grep $pid_or_name | awk '{print $1}' | head -n 1)
    if [ -z "$pid" ]; then
        echo "Process not found"
    else
        ps -p $pid -o etime,comm
    fi
    ;;

listOrphanProcess)
    ps -eo pid,ppid,comm | awk '$2==1 {print $0}'
    ;;

listZoombieProcess)
    ps -eo pid,stat,comm | awk '$2=="Z" {print $0}'
    ;;

killProcess)
    pid_or_name=$arg1
    pid=$(ps -e -o pid,comm | grep $pid_or_name | awk '{print $1}' | head -n 1)
    if [ -z "$pid" ]; then
        echo "Process not found"
    else
        kill -9 $pid
        echo "Killed process $pid_or_name (PID $pid)"
    fi
    ;;

ListWaitingProcess)
    ps -eo pid,stat,comm | awk '$2 ~ /D/ {print $0}'
    ;;

*)
    echo "Invalid command"
    ;;

esac
