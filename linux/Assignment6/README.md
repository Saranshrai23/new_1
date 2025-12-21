# Linux Assignment 06 Shell Scripting Assignment  – Process Management Utility

This assignment contains **two Bash scripts** for basic process and service management:

1. **`otProcessManager.sh`** – Basic process management utility (Part A)
2. **`ProcessManager.sh`** – Service/daemon manager (Part B)


---

## Files in this Repository

```text
.
├── otProcessManager.sh      # Part A – Process Management
├── ProcessManager.sh        # Part B – Service/Daemon Manager
├── logs/                    # Folder for log files
│   └── process.log
├── screenshots/             # Folder to store output screenshots
└── README.md
```

---

# Part A – `otProcessManager.sh`

### Description

This script performs **basic process management**:

* Display top `n` processes by memory or CPU
* Kill process with **lowest priority**
* Show running duration of a process by name or PID
* List **orphan** and **zombie** processes
* Kill a process by name or PID
* List processes waiting for resources

---

### Usage

```bash
chmod +x otProcessManager.sh
./otProcessManager.sh <command> [args]
```

### Example Commands

```bash
./otProcessManager.sh topProcess 5 memory
./otProcessManager.sh topProcess 10 cpu
./otProcessManager.sh killLeastPriorityProcess
./otProcessManager.sh RunningDurationProcess bash
./otProcessManager.sh listOrphanProcess
./otProcessManager.sh listZoombieProcess
./otProcessManager.sh killProcess nano
./otProcessManager.sh ListWaitingProcess
```

---

### Example  Script

```bash
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
```

---

#  Part B – `ProcessManager.sh`

### Description

A **simple service manager** that allows you to:

* Register a script as a service with an alias
* Start, stop, or check the status of a service
* Change service priority (low, medium, high)
* List all registered services

---

### Usage

```bash
chmod +x ProcessManager.sh
./ProcessManager.sh -o register -s <script_path> -a <alias>
./ProcessManager.sh -o start -a <alias>
./ProcessManager.sh -o status -a <alias>
./ProcessManager.sh -o kill -a <alias>
./ProcessManager.sh -o priority -p <low/med/high> -a <alias>
./ProcessManager.sh -o list
```

---

### Example  Script

```bash
#!/bin/bash

LOG_FILE="logs/process.log"
mkdir -p logs

while getopts "o:s:a:p:" opt; do
    case $opt in
        o) operation=$OPTARG ;;
        s) scriptPath=$OPTARG ;;
        a) aliasName=$OPTARG ;;
        p) priority=$OPTARG ;;
        *) echo "Invalid option" ;;
    esac
done

case $operation in

register)
    echo "$aliasName,$scriptPath" >> $LOG_FILE
    echo "Service $aliasName registered"
    ;;

start)
    scriptPath=$(grep "^$aliasName," $LOG_FILE | cut -d, -f2)
    if [ -z "$scriptPath" ]; then
        echo "Service not found"
    else
        bash "$scriptPath" &
        echo $! > logs/$aliasName.pid
        echo "Service $aliasName started"
    fi
    ;;

status)
    if [ -f logs/$aliasName.pid ]; then
        pid=$(cat logs/$aliasName.pid)
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
    if [ -f logs/$aliasName.pid ]; then
        pid=$(cat logs/$aliasName.pid)
        kill -9 $pid
        echo "Service $aliasName killed (PID $pid)"
        rm -f logs/$aliasName.pid
    else
        echo "Service not running"
    fi
    ;;

priority)
    if [ -f logs/$aliasName.pid ]; then
        pid=$(cat logs/$aliasName.pid)
        case $priority in
            low) renice 19 -p $pid ;;
            med) renice 10 -p $pid ;;
            high) renice -10 -p $pid ;;
        esac
        echo "Priority of $aliasName changed to $priority"
    else
        echo "Service not running"
    fi
    ;;

list)
    cat $LOG_FILE
    ;;

*)
    echo "Invalid operation"
    ;;

esac
```

---

# Screenshots

```markdown
## Screenshots

### Part A – Process Manager
![Process Manager](screenshots/process_manager.png)

### Part B – Service Manager
![Service Manager](screenshots/service_manager.png)
```

---

# Notes

* Uses basic Bash commands: `ps`, `awk`, `grep`, `kill`, `renice`
* Logs are used to track services and PIDs
* Scripts work on Linux, macOS, and WSL

---

## Author

**Gourav Sharma**
DevOps Learner |Bash | Aws
---