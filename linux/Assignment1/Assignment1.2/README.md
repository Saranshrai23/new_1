# Linux Assignment 01.2 – File & Directory Management Bash Script

This Bash script provides a simple command-line interface to manage **files and directories**.
You can create, delete, list, move, copy files/directories, and also **read or modify file content** from specific lines.

---

## Features

### Directory Operations

* Create a directory
* Delete a directory
* List files in a directory
* List directories
* List all contents

### File Operations

* Create a file (with or without content)
* Append content to a file
* Add content at the beginning of a file
* Show file content:

  * Beginning lines
  * Ending lines
  * Specific line number
  * Line range
* Move a file
* Copy a file
* Clear file content
* Delete a file

---

## Prerequisites

* Linux / macOS
* Bash shell
* Basic file system permissions

---

## Script Usage

```bash
./script.sh <action> <path> <name> [arg4] [arg5]
```

### Arguments Explanation

| Argument | Description                                             |
| -------- | ------------------------------------------------------- |
| `action` | Operation to perform                                    |
| `path`   | Directory path                                          |
| `name`   | File or directory name                                  |
| `arg4`   | Optional (content, line number, destination path, etc.) |
| `arg5`   | Optional (used for line range)                          |

---

## Supported Actions & Examples

### Directory Commands

#### Create Directory

```bash
./script.sh addDir /home/ubuntu testDir
```

#### Delete Directory

```bash
./script.sh deleteDir /home/ubuntu testDir
```

#### List Files

```bash
./script.sh listFiles /home/ubuntu
```

#### List Directories

```bash
./script.sh listDirs /home/ubuntu
```

#### List All

```bash
./script.sh listAll /home/ubuntu
```

---

### File Commands

#### Create File (Empty)

```bash
./script.sh addFile /home/ubuntu test.txt
```

#### Create File With Content

```bash
./script.sh addFile /home/ubuntu test.txt "Hello World"
```

#### Append Content to File

```bash
./script.sh addContentToFile /home/ubuntu test.txt "New Line"
```

#### Add Content at Beginning

```bash
./script.sh addContentToFileBegining /home/ubuntu test.txt "First Line"
```

---

### Read File Content

#### Show First N Lines

```bash
./script.sh showFileBeginingContent /home/ubuntu test.txt 5
```

#### Show Last N Lines

```bash
./script.sh showFileEndContent /home/ubuntu test.txt 5
```

#### Show Specific Line

```bash
./script.sh showFileContentAtLine /home/ubuntu test.txt 10
```

#### Show Line Range

```bash
./script.sh showFileContentForLineRange /home/ubuntu test.txt 5 10
```

---

###  File Move & Copy

#### Move File

```bash
./script.sh moveFile /home/ubuntu test.txt /tmp/test.txt
```

#### Copy File

```bash
./script.sh copyFile /home/ubuntu test.txt /tmp/test.txt
```

---

###  Cleanup Operations

#### Clear File Content

```bash
./script.sh clearFileContent /home/ubuntu test.txt
```

#### Delete File

```bash
./script.sh deleteFile /home/ubuntu test.txt
```

---


###  Reference screenshots in README.md

```markdown
## 📸 Screenshots

### Add File Example
![Add File](screenshots/add-file.png)

### List Files Example
![List Files](screenshots/list-files.png)
```

---

## Notes

* Ensure the script has execute permission:

```bash
chmod +x script.sh
```

* Paths must exist before performing file operations.
* Use quotes when passing content with spaces.

---

## Author

**Gourav Sharma**
DevOps Learner | Linux | AWS | Bash |

---

