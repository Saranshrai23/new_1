#!/bin/bash
# set -x
# ---- Step 1: Run only as root ----
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root or using sudo"
    exit 1
fi

# ---- Step 2: Check at least one argument ----
if [ $# -lt 1 ]; then
    echo "Usage: ./UserManager.sh <action> [arguments]"
    echo ""
    echo "Actions:"
    echo "  addTeam <teamname>"
    echo "  addUser <username> <teamname>"
    echo "  changeShell <username> <shell>"
    echo "  changePasswd <username>"
    echo "  delUser <username>"
    echo "  delTeam <teamname>"
    echo "  ls User"
    echo "  ls Team"
    exit 1
fi

action=$1

# ADD TEAM (GROUP)

if [ "$action" = "addTeam" ]; then

    team=$2
    if [ -z "$team" ]; then
        echo "Usage: ./UserManager.sh addTeam <teamname>"
        exit 1
    fi

    if getent group "$team" > /dev/null; then
        echo "Team $team already exists"
    else
        groupadd "$team"
        echo "Team $team created successfully"
    fi

fi

# ADD USER

elif [ "$action" = "addUser" ]; then

    user=$2
    team=$3

    if [ -z "$user" ] || [ -z "$team" ]; then
        echo "Usage: ./UserManager.sh addUser <username> <teamname>"
        exit 1
    fi

    if ! getent group "$team" > /dev/null; then
        echo "Team $team does not exist"
        exit 1
    fi

    if getent passwd "$user" > /dev/null; then
        echo "User $user already exists"
        exit 1
    fi

    # Create user with home directory
    useradd -m -g "$team" "$user"

    # Home directory permissions
    # User: rwx, Team: r-x, Others: --x
    chmod 751 /home/"$user"

    # Create shared directories
    mkdir /home/"$user"/team
    mkdir /home/"$user"/ninja

    # TEAM directory (same team full access)
    chown "$user":"$team" /home/"$user"/team
    chmod 770 /home/"$user"/team

    # NINJA directory (all ninja users full access)
    groupadd -f ninja
    usermod -aG ninja "$user"
    chown "$user":ninja /home/"$user"/ninja
    chmod 770 /home/"$user"/ninja

    echo "User $user added to team $team successfully"
fi

# CHANGE USER SHELL

elif [ "$action" = "changeShell" ]; then

    user=$2
    shell=$3

    if [ -z "$user" ] || [ -z "$shell" ]; then
        echo "Usage: ./UserManager.sh changeShell <username> <shell>"
        exit 1
    fi

    if ! getent passwd "$user" > /dev/null; then
        echo "User $user does not exist"
        exit 1
    fi

    if ! grep -q "^$shell$" /etc/shells; then
        echo "Invalid shell. Check /etc/shells"
        exit 1
    fi

    chsh -s "$shell" "$user"
    echo "Shell changed for $user"
fi

# CHANGE PASSWORD

elif [ "$action" = "changePasswd" ]; then

    user=$2
    if [ -z "$user" ]; then
        echo "Usage: ./UserManager.sh changePasswd <username>"
        exit 1
    fi

    if ! getent passwd "$user" > /dev/null; then
        echo "User $user does not exist"
        exit 1
    fi

    passwd "$user"
fi

# DELETE USER

elif [ "$action" = "delUser" ]; then

    user=$2
    if [ -z "$user" ]; then
        echo "Usage: ./UserManager.sh delUser <username>"
        exit 1
    fi

    if ! getent passwd "$user" > /dev/null; then
        echo "User $user does not exist"
        exit 1
    fi

    userdel -r "$user"
    echo "User $user deleted successfully"
fi 

# DELETE TEAM

elif [ "$action" = "delTeam" ]; then

    team=$2
    if [ -z "$team" ]; then
        echo "Usage: ./UserManager.sh delTeam <teamname>"
        exit 1
    fi

    if ! getent group "$team" > /dev/null; then
        echo "Team $team does not exist"
        exit 1
    fi

    gid=$(getent group "$team" | cut -d: -f3)
    users=$(awk -F: -v gid="$gid" '$4 == gid {print $1}' /etc/passwd)

    if [ -n "$users" ]; then
        echo "Cannot delete team $team. Users still exist:"
        echo "$users"
        exit 1
    fi

    groupdel "$team"
    echo "Team $team deleted successfully"
fi

# LIST USERS OR TEAMS
 
elif [ "$action" = "ls" ]; then

    if [ "$2" = "User" ]; then
        echo "Users:"
        cut -d: -f1 /etc/passwd
    elif [ "$2" = "Team" ]; then
        echo "Teams:"
        cut -d: -f1 /etc/group
    else
        echo "Usage: ./UserManager.sh ls User|Team"
    fi

else
    echo "Invalid action"
fi
