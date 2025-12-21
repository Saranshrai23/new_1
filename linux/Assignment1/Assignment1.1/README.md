
# Linux Assignment 01.1 – File and Directory Operations

This assignment demonstrates **basic Linux commands** for creating, modifying, and managing files and directories.
---

## Directory Structure

```text
.
├── linux/
│   └── Assignment-01/
├── tmp/
│   ├── dir1/
│   │   └── dir2/
│   │       ├── Sharma
│   │       └── Sharma.copy
│   └── Gourav
│   └── Sharma
```

---

## Commands Used

### 1. Working Directory and Creating Directories

```bash
pwd
mkdir -p linux/Assignment-01
mkdir /tmp/dir1
mkdir -p /tmp/dir1/{dir2,dir3}
rmdir /tmp/dir1/dir3
```

* `pwd` – Print working directory
* `mkdir -p` – Create directories recursively
* `rmdir` – Remove empty directory

---

### 2. Creating and Writing to Files

```bash
touch /tmp/Gourav
echo 'This is my first line' > /tmp/Gourav
echo 'this is a additional content' >> /tmp/Gourav

echo 'Sharma is my last name' > /tmp/Sharma
```

* `touch` – Create empty file
* `>` – Write to a file (overwrite)
* `>>` – Append content to a file

---

### 3. Adding Content at Beginning of a File

```bash
( echo 'this is line at the beginning' ; cat /tmp/Sharma ) > /tmp/Sharma.tmp && mv /tmp/Sharma.tmp /tmp/Sharma
```

* Combines `echo` and `cat` to add a line at the **beginning**
* `mv` replaces original file with modified file

---

### 4. Adding Multiple Lines at the End

```bash
cat >> /tmp/Sharma <<'EOF'
extra line 1
extra line 2
extra line 3
extra line 4
extra line 5
extra line 6
extra line 7
extra line 8
EOF
```

* `<<'EOF'` – Here-document for multi-line input

---

### 5. Displaying File Content

```bash
head -n 5 /tmp/Sharma          # First 5 lines
tail -n 2 /tmp/Sharma          # Last 2 lines
head -n 6 /tmp/Sharma | tail -n 1  # 6th line
head -n 8 /tmp/Sharma | tail -n 6  # Lines 3-8
```

* `head` – Show first `n` lines
* `tail` – Show last `n` lines
* Combine `head` and `tail` for line ranges

---

### 6. Listing Files and Directories

```bash
ls -la /tmp
find /tmp -maxdepth 1 -type f -printf '%f\n'
find /tmp -maxdepth 1 -mindepth 1 -type d -printf '%f\n'
```

* `ls -la` – List all files with details
* `find` – List files or directories

---

### 7. Copying and Moving Files

```bash
cp /tmp/Sharma /tmp/dir2/
cp /tmp/Sharma /tmp/dir2/Sharma.copy

mv /tmp/Gourav /tmp/Gourav-renamed
mv /tmp/Sharma /tmp/dir1/
```

* `cp` – Copy file
* `mv` – Move or rename file

---

### 8. Clearing and Deleting Files

```bash
> /tmp/dir2/Sharma.copy   # Clear content
rm /tmp/dir2/Sharma.copy  # Delete file
```

* `>` – Empty a file
* `rm` – Remove file

---

## Screenshots

```markdown
## Screenshots

### Listing Directories and Files
![Directories](screenshots/list_dirs.png)

### File Content Display
![File Content](screenshots/file_content.png)

### Copying and Moving Files
![Copy Move](screenshots/copy_move.png)
```

---

## Author

**Gourav Sharma**
DevOps Learner | Linux | AWS | Bash 

---
