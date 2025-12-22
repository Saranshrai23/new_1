#!/bin/bash

LOG_FILE="logs/process.log"
mkdir -p logs

while getopts "o:s:a:p:" opt; do
    case $opt in
        o) operation=$OPTARG ;;
        s) scriptPath=$OPTARG ;;
        a) aliasName=$OPTARG ;;
        p) priority=$OPTARG ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

case $operation in

register)
    if grep -q "^$aliasName," "$LOG_FILE"; then
        echo "Service $aliasName already registered"
    else
        echo "$aliasName,$scriptPath" >> "$LOG_FILE"
        echo "Service $aliasName registered"
    fi
    ;;

start)
    scriptPath=$(grep "^$aliasName," "$LOG_FILE" | cut -d, -f2)
    if [ -z "$scriptPath" ]; then
        echo "Service not found"
    else
        if [ ! -f "$scriptPath" ]; then
            echo "Error: Script $scriptPath does not exist."
            exit 1
        fi

        bash "$scriptPath" &
        echo $! > "logs/$aliasName.pid"
        echo "Service $aliasName started (PID $!)"
    fi
    ;;

status)
    if [ -f "logs/$aliasName.pid" ]; then
        pid=$(cat "logs/$aliasName.pid")
        if ps -p $pid > /dev/null; then
            echo "Service $aliasName is running (PID $pid)"
        else
            echo "Service $aliasName is not running"
        fi
    else
        echo "Service $aliasName not started"
    fi
    ;;

kill)
    if [ -f "logs/$aliasName.pid" ]; then
        pid=$(cat "logs/$aliasName.pid")
        kill -9 $pid
        echo "Service $aliasName killed (PID $pid)"
        rm -f "logs/$aliasName.pid"
    else
        echo "Service not running"
    fi
    ;;

priority)
    if [ -f "logs/$aliasName.pid" ]; then
        pid=$(cat "logs/$aliasName.pid")
        case $priority in
            low) renice 19 -p $pid ;;
            med) renice 10 -p $pid ;;
            high) renice -10 -p $pid ;;
            *) echo "Invalid priority. Use low, med, or high"; exit 1 ;;
        esac
        echo "Priority of $aliasName changed to $priority"
    else
        echo "Service not running"
    fi
    ;;

list)
    cat "$LOG_FILE"
    ;;

*)
    echo "Invalid operation"
    ;;

esac
