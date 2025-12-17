#!/bin/bash
# set -x
CONFIG="/home/$USER/.ssh/config"
# -----Usage function-----
usage() {
    echo "Usage: $0 -a -n <server_name> -h <ip_addr> -u <username> [-p <port>] [-i <identity_file>]"
    echo "OR"
    echo "       $0 ls -d   --> List saved SSH configs"
    echo "       $0 rm <server_name>  --> Delete SSH config block"
    exit 1
}
# -----Getopts for passing argument -----
OPTSTRING="Uan:h:u:p:i:"
while getopts "$OPTSTRING" opt; do
  case "$opt" in
    a) add_user_flag=1 ;;
    n) server_name="$OPTARG" ;;
    h) ip_addr="$OPTARG" ;;
    u) username="$OPTARG" ;;
    p) port="$OPTARG" ;;
    i) identity_file="$OPTARG" ;;
    U) update_ssh_connection_flag=1 ;;
    ?) usage ;;
  esac
done
# -----Functions---------
ssh_dir() {
    if [[ ! -d "/home/$USER/.ssh" ]]; then
        echo "Creating .ssh directory"
        mkdir -p "/home/$USER/.ssh"
        chmod 700 "/home/$USER/.ssh"
    fi
    if [[ ! -f "$CONFIG" ]]; then
        echo "Creating SSH config file"
        touch "$CONFIG"
        chmod 600 "$CONFIG"
    fi
}
add_server_name() {
    if [[ -z "$server_name" ]]; then
        echo "Missing -n <server_name>"
        usage
    fi
    if grep -wq "^Host $server_name$" "$CONFIG" 2>/dev/null ; then
        echo "Error: Server name $server_name already exists."
        exit 1
    fi
    echo "Step 1: Adding server name to SSH config"
   
    cat >> "$CONFIG" << EOF
Host $server_name
EOF
}
add_user() {
    if [[ -z "$username" || -z "$ip_addr" || -z "$server_name" ]]; then
        echo "Missing arguments"
        usage
    fi
    if grep -wq "^Hostname $ip_addr$" "$" 2>/dev/null ; then
        echo "Error: Hostname $ip_addr already exists."
        exit 1
    fi
    echo "Step 2: Adding user and hostname to SSH config"
    cat >> "$CONFIG" << EOF
    HostName $ip_addr
    User $username
EOF
}
add_port() {
    if [[ -z "$port" ]]; then
        echo "Missing -p <port>"
        usage
    fi
    # Check if the port already exists in the config
    if grep -qw "^Port $port$" "$CONFIG" 2>/dev/null; then
        echo "Error: Port $port already exists."
        exit 1
    fi
    echo "Adding port to SSH config"
    cat >> "$CONFIG" << EOF
    Port $port
EOF
}
copy_identity_file () {
    if [[ -z "$username" || -z "$ip_addr" ]]; then
        echo "Missing required -u or -h argument."
        usage
    fi
    identity_file="/home/$username/.ssh/${username}_id_rsa"
    echo "Generating SSH keys..."
    sudo -u "$username" ssh-keygen -t rsa -f "$identity_file" -C "$server_name" -N "" <<< y
    echo "Copying key to remote..."
    sudo cp "$identity_file.pub" /home/$USER/.ssh/${username}_id_rsa.pub
cat >> "$CONFIG" <<EOF
    IdentityFile $identity_file
EOF
exit 0
}
connect_to_server() {
    local server="$1"
    # Check if host exists
    if ! grep -qw "Host $server" "$CONFIG"; then
        echo "[ERROR]: Server information is not available, please add server first"
        return 1
    fi
    hostname=$(sed -n "/Host $server\$/,/^Host /p" "$CONFIG" | grep "HostName" | awk '{print $2}')
    user=$(sed -n "/Host $server\$/,/^Host /p" "$CONFIG" | grep "User" | awk '{print $2}')
    port=$(sed -n "/Host $server\$/,/^Host /p" "$CONFIG" | grep "Port" | awk '{print $2}')
    identity=/home/$USER/.ssh/ubuntu_id_rsa.pub
    echo "changing permission of key file"
    sudo chmod 600 $identity
    [[ -z "$port" ]] && port=22
    echo "Connecting to $server on $port port as $user via ${identity:-no_key} key"
    if [[ ! -z "$identity" ]]; then
        ssh -i "$identity" -p "$port" "$user@$hostname"
    else
        ssh -p "$port" "$user@$hostname"
    fi
    if [[ $? -ne 0 ]]; then
        echo "Connection on $port port to $server failed"
        echo "Connecting to $server on default 22 port"
        ssh "$user@$hostname"
        exit 1
    fi
}
update_ssh_connection() {
sed -i "/^Host $server_name\$/,/^Host / s/^[[:space:]]*HostName .*/    HostName $ip_addr/" "$CONFIG"
sed -i "/^Host $server_name\$/,/^Host / s/^[[:space:]]*User .*/    User $username/" "$CONFIG"
sed -i "/^Host $server_name\$/,/^Host / s/^[[:space:]]*Port .*/    Port $port/" "$CONFIG"
echo "SSH connection updated successfully."
}
list_SSH_entries() {
    CONFIG="/home/$USER/.ssh/config"
    if [[ ! -f "$CONFIG" ]]; then
        echo "No SSH config file found."
        exit 1
    fi
    if [[ "$1" == "ls" && -z "$2" ]]; then
        echo "Saved Servers:"
        echo "=============="
        awk '/^Host / { print $2 }' "$CONFIG"
        exit 0
    fi
    if [[ "$1" == "ls" && "$2" == "-d" ]]; then
        echo "Saved SSH Config Details:"
        echo "========================="
        echo
        awk '
        /^Host / { host=$2 }
        /HostName/ { hostname=$2 }
        /User/ { sshuser=$2 }
        /Port/ { port=$2 }
        /IdentityFile/ { key=$2 }
        /^$/ {
            if (host != "") {
                printf "%s: ssh ", host
                if (key != "") printf "-i %s ", key
                if (port != "") printf "-p %s ", port
                printf "%s@%s\n\n", sshuser, hostname
            }
            host=""; hostname=""; sshuser=""; port=""; key=""
        }
        ' "/home/$USER/.ssh/config"
        exit 0
    fi
}
delete_ssh_entry() {
server_name="$2"
    if [[ "$1" != "rm" ]]; then return; fi
    if grep -q "^Host $server_name$" "$CONFIG"; then
        sudo sed -i "/^Host $server_name\$/, /^Host / { /^Host $server_name\$/d; /HostName/d; /User/d; /Port/d; /IdentityFile/d }" "$CONFIG"
        echo "Deleted entry for $server_name"
    else
        echo "Entry not found"
    fi
    exit 0
}
# ----To connect directly if server name is provided as first argument----
if [[ -f "$CONFIG" ]]; then
    if grep -qw "^Host $1$" "$CONFIG"; then
        connect_to_server "$1"
        exit 0
    fi
fi
case "$1" in
    ls) list_SSH_entries "$@" ;;
    rm) delete_ssh_entry "$@" ;;
    *) ;;
esac
[[ $add_user_flag == 1 ]] && ssh_dir && add_server_name && add_user
[[ $add_user_flag == 1 && -n "$port" ]] && add_port
[[ $add_user_flag == 1 && -n "$identity_file" ]] && copy_identity_file
[[ -n "$update_ssh_connection_flag" ]] && update_ssh_connection "$server_name" "$ip_addr" "$username" "$port"
exit 0