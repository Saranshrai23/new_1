

<p align="left">
  <img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/d45eabda-c72c-49bc-8075-930bc54c34ec" />
  <br/>
</p>

# SOP: Migrate Installation Guide

---

# Document Details

| Author | Created on | Version | Last updated by | Last Edited On | L0 Reviewer | L1 Reviewer | L2 Reviewer |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Saransh Rai | 17-04-2026 | 1.0 | Saransh Rai | 17-04-2026 | Anuj Jain | Prashant Sharma | Piyush Upadhyay |

---

# Table of Contents

1. [Overview](#1-overview)
2. [Pre-requisites](#2-pre-requisites)
3. [Installation Methods](#3-installation-methods)
   - [3.1 Linux (Ubuntu)](#31-linux-ubuntu)
     - [3.1.1 Prebuilt Binary Installation](#311-prebuilt-binary-installation)
     - [3.1.2 APT Installation](#312-apt-installation)
   - [3.2 macOS](#32-macos)
   - [3.3 Windows](#33-windows)
4. [Verification](#4-verification)
5. [Basic Validation](#5-basic-validation)
6. [Upgrade Migrate](#6-upgrade-migrate)
7. [Uninstall Migrate](#7-uninstall-migrate)
8. [Common Errors and Fixes](#8-common-errors-and-fixes)
9. [Best Practices](#9-best-practices)
10. [Conclusion](#10-conclusion)
11. [Contact Information](#11-contact-information)
12. [References](#12-references)

---

# 1. Overview

This SOP provides the steps to install, configure, validate, and troubleshoot the migrate CLI tool across different operating systems. It helps ensure reliable and consistent database migration management.

---

# 2. Pre-requisites

| Requirement | Description |
| --- | --- |
| Access | Sudo/Admin privileges are required to install packages and move binaries into system directories |
| curl | Used to download binaries and repository keys from the internet |
| tar | Used to extract compressed `.tar.gz` files |
| gnupg | Used to verify and manage GPG keys for secure package installation |

## Install Dependencies

### Linux (Ubuntu)

| Command | Explanation |
| --- | --- |
| `sudo apt update` | Updates package list |
| `sudo apt install -y curl tar gnupg lsb-release` | Installs required tools |

<details>
<summary>Installing dependencies - click to expand</summary>
<img width="1452" height="432" alt="image" src="https://github.com/user-attachments/assets/de7fb37c-1803-481b-8c20-65f28f2c734f" />
</details>

<details>
<summary>Installing dependencies - click to expand</summary>
<img width="1392" height="457" alt="image" src="https://github.com/user-attachments/assets/37374966-ed5c-4df0-b7fb-c5416b99d7a7" />
</details>

---

### macOS

| Command | Explanation |
| --- | --- |
| `brew install curl gnupg` | Installs required tools using Homebrew |

---

### Windows

| Method | Description |
| --- | --- |
| Chocolatey | `choco install curl gnupg` |
| Manual | Install Git Bash or WSL for required tools |

---

# 3. Installation Methods

The migrate CLI can be installed using either the **Prebuilt Binary method** or the **APT package manager method**. Binary installation provides more control over versions and manual setup, while APT installation simplifies dependency management and upgrades.

---

# 3.1 Linux (Ubuntu)

## 3.1.1 Prebuilt Binary Installation

This method downloads the compiled binary directly from the official GitHub release and configures it manually on the system.

### Download Binary

| Command | Explanation |
| --- | --- |
| `curl -L https://github.com/golang-migrate/migrate/releases/latest/download/migrate.linux-amd64.tar.gz \| tar xvz` | Downloads and extracts migrate binary |

<details>
<summary>Downloading migrate binary - click to expand</summary>

<img width="800" src="https://github.com/user-attachments/assets/78949466-fb66-4f73-afcb-bbe412321811" />

</details>

---

### Move Binary to System Path

| Command | Explanation |
| --- | --- |
| `sudo mv migrate /usr/local/bin/` | Moves binary to system path |

<details>
<summary>Moving binary - click to expand</summary>

<img width="400" src="https://github.com/user-attachments/assets/abbbc8b8-a5c2-4173-a9f6-2cd044a75263" />

</details>

---

### Set Execute Permission

| Command | Explanation |
| --- | --- |
| `sudo chmod +x /usr/local/bin/migrate` | Grants execution permission |

<details>
<summary>Setting permission - click to expand</summary>

<img width="400" src="https://github.com/user-attachments/assets/49280906-a39d-4939-bbe0-f861de8e0a7f" />

</details>

---

## 3.1.2 APT Installation

This method installs migrate using Ubuntu package repositories.

### Add GPG Key

| Command | Explanation |
| --- | --- |
| `curl -fsSL https://packagecloud.io/golang-migrate/migrate/gpgkey \| sudo gpg --dearmor -o /etc/apt/keyrings/migrate.gpg` | Adds repository GPG key |

---

### Add Repository

| Command | Explanation |
| --- | --- |
| `echo "deb [signed-by=/etc/apt/keyrings/migrate.gpg] https://packagecloud.io/golang-migrate/migrate/ubuntu/ $(lsb_release -sc) main" \| sudo tee /etc/apt/sources.list.d/migrate.list` | Adds migrate repository |

<details>
<summary>Adding repository - click to expand</summary>

<img width="800" src="https://github.com/user-attachments/assets/d8222905-67ce-48b3-9bd6-d6b8415236fc" />

</details>

---

### Install Migrate

| Command | Explanation |
| --- | --- |
| `sudo apt update && sudo apt install -y migrate` | Installs migrate tool |

<details>
<summary>Installing migrate - click to expand</summary>

<img width="800" src="https://github.com/user-attachments/assets/2fa1f3ec-d3c9-4be6-a384-a1e2c652e01a" />

</details>

---

# 3.2 macOS

| Method | Command |
| --- | --- |
| Homebrew | `brew install golang-migrate` |

---

# 3.3 Windows

| Method | Command |
| --- | --- |
| Chocolatey | `choco install golang-migrate` |

---

# 4. Verification

After installation, verify whether the migrate CLI is properly installed and accessible through the system path.

| Command | Explanation |
| --- | --- |
| `migrate -version` | Displays installed version |
| `which migrate` | Shows installation path |

<details>
<summary>Verification - click to expand</summary>

<img width="400" src="https://github.com/user-attachments/assets/65ea63af-6460-49c8-b63c-8b9b179817a8" />

</details>

---

# 5. Basic Validation

The following command creates migration files and validates whether the migrate CLI is functioning properly.

| Command | Explanation |
| --- | --- |
| `migrate create -ext sql -dir migrations -seq init` | Creates migration files |

<details>
<summary>Validation - click to expand</summary>

<img width="500" src="https://github.com/user-attachments/assets/86b498fd-2a63-4791-a85f-065a73bb4cf8" />

</details>

---

# 6. Upgrade Migrate

| Command | Explanation |
| --- | --- |
| `sudo apt update && sudo apt upgrade migrate -y` | Upgrades migrate tool |

---

# 7. Uninstall Migrate

| Method | Command | Explanation |
| --- | --- | --- |
| Binary | `sudo rm /usr/local/bin/migrate` | Removes manual installation |
| APT | `sudo apt remove migrate -y` | Removes APT installation |

---

# 8. Common Errors and Fixes

| Error | Cause | Solution |
| --- | --- | --- |
| `migrate: command not found` | Binary not in PATH | Ensure the binary exists in `/usr/local/bin` and verify using `echo $PATH` |
| `permission denied` | Missing execute permission | Run `sudo chmod +x /usr/local/bin/migrate` |
| `package not found` | Repository missing | Re-add repository and run `sudo apt update` |
| `wrong architecture` | Incorrect binary downloaded | Download the correct architecture binary (`amd64`, `arm64`) |
| `network error` | Connectivity issue | Verify internet, DNS, or firewall settings |

---

# 9. Best Practices

| Practice | Explanation |
| --- | --- |
| Use version-controlled migrations | Store migration files in Git repositories |
| Test before production | Validate migrations in staging environments |
| Avoid manual DB changes | Prefer migration scripts over direct edits |
| Maintain naming conventions | Use meaningful migration file names |
| Automate in CI/CD | Integrate migrations into deployment pipelines |

---

# 10. Conclusion

This SOP provides a complete and structured process for installing, validating, upgrading, and troubleshooting the migrate CLI tool across different operating systems. Following these practices ensures reliable database migration workflows, reduces deployment issues, and improves consistency across environments.

---

# 11. Contact Information

| Name | Email |
| --- | --- |
| Saransh Rai | saransh.rai.snaatak@mygurukulam.co |

---

# 12. References

| Topic | Description |
| --- | --- |
| [golang-migrate Repository](https://github.com/golang-migrate/migrate) | Official source code and project repository |
| [migrate CLI Tool](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate) | Official migrate command-line documentation |
