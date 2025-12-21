# Linux Assignment 02 – UserManager.sh – Linux User & Team Management Script

`UserManager.sh` is a **Bash-based user and group (team) management tool** designed for Linux systems.
It helps system administrators automate common tasks such as:

* Creating teams (groups)
* Adding users with controlled permissions
* Managing shells and passwords
* Deleting users and teams safely
* Listing users and teams

**This script must be run as root or with sudo.**

---

## Features

### Team (Group) Management

* Create a new team
* Delete a team (only if no users exist)

###  User Management

* Add users with:

  * Home directory
  * Team-based access
  * Shared `team` directory
  * Shared `ninja` directory (cross-team collaboration)
* Change user login shell
* Change user password
* Delete users with home directory cleanup

###  Listing

* List all users
* List all teams

---

##  Prerequisites

* Linux OS
* Bash shell
* Root or sudo access

---

## Script Usage

```bash
sudo ./UserManager.sh <action> [arguments]
```

---

## Supported Actions

### Add Team

```bash
sudo ./UserManager.sh addTeam <teamname>
```

Example:

```bash
sudo ./UserManager.sh addTeam devops
```

---

### Add User

```bash
sudo ./UserManager.sh addUser <username> <teamname>
```

Example:

```bash
sudo ./UserManager.sh addUser gourav devops
```

Automatically:

* Creates home directory
* Sets permissions
* Creates `team` and `ninja` directories
* Adds user to `ninja` group

---

### Change User Shell

```bash
sudo ./UserManager.sh changeShell <username> <shell>
```

Example:

```bash
sudo ./UserManager.sh changeShell gourav /bin/bash
```

 shells are checked from `/etc/shells`.

---

### Change User Password

```bash
sudo ./UserManager.sh changePasswd <username>
```

Example:

```bash
sudo ./UserManager.sh changePasswd gourav
```

---

### Delete User

```bash
sudo ./UserManager.sh delUser <username>
```

Example:

```bash
sudo ./UserManager.sh delUser gourav
```

Removes user **along with home directory**.

---

### Delete Team

```bash
sudo ./UserManager.sh delTeam <teamname>
```

Example:

```bash
sudo ./UserManager.sh delTeam devops
```

Team deletion is blocked if users still belong to the team.

---

### List Users or Teams

#### List Users

```bash
sudo ./UserManager.sh ls User
```

#### List Teams

```bash
sudo ./UserManager.sh ls Team
```

---

## Directory Structure Created for Each User

```text
/home/username/
├── team/    (team members full access)
└── ninja/   (shared across all ninja users)
```

### Permissions

* `team` directory → `770` (user + team)
* `ninja` directory → `770` (shared group)

---

## Adding Screenshots

### 1️  Create a screenshots folder

```bash
mkdir screenshots
```

### 2️ Add images

Example structure:

```text
screenshots/
├── add-team.png
├── add-user.png
├── list-users.png
└── delete-user.png
```

### 3️ Add screenshots to README.md

```markdown
## Screenshots

### Add Team
![Add Team](screenshots/add-team.png)

### Add User
![Add User](screenshots/add-user.png)

### List Users
![List Users](screenshots/list-users.png)
```



---

## Safety Notes

* Script must be run as **root**
* Validates:

  * Existing users
  * Existing teams
  * Valid shells
* Prevents accidental deletion of active teams

---

## Author

**Gourav Sharma**
Linux | DevOps | AWS | Bash 
---