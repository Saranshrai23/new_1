Check current working directory

pwd


Explanation: pwd prints the current working directory (the folder you’re in). Use it first to know where you are (so when you create a linux folder it will be created inside this directory).

Create directory named linux in current directory

mkdir linux


Explanation: mkdir = make directory. This creates a folder called linux inside the directory shown by pwd. If linux already exists, you’ll get an error (use mkdir -p to avoid an error, see below).

Create Assignment-01 inside linux

mkdir -p linux/Assignment-01


Explanation: -p makes parent directories as needed and does not error if they already exist. This creates linux/Assignment-01 relative to your current directory.

Create /tmp/dir1 without changing your present directory

mkdir /tmp/dir1


Explanation: Giving an absolute path (/tmp/dir1) means the shell creates it in /tmp no matter where you currently are. You didn’t cd anywhere.

Create the /tmp/dir1 subtree (dir2 and dir3) with a single command
Two options (either works). Both create /tmp/dir1/dir2 and /tmp/dir1/dir3.

Option A (brace expansion — short):

mkdir -p /tmp/dir1/{dir2,dir3}


Option B (explicit):

mkdir -p /tmp/dir1/dir2 /tmp/dir1/dir3


Explanation: mkdir -p ensures parent exists and creates both directories in one line. The brace {dir2,dir3} expands to two paths.

Delete dir3 you created before
If dir3 is empty:

rmdir /tmp/dir1/dir3


If dir3 may contain files and you want to remove it and its contents:

rm -r /tmp/dir1/dir3


Explanation: rmdir removes empty directories only. rm -r removes recursively (contents + directory). Use rm -r with care.

Create an empty file named <first-name> in /tmp

touch /tmp/<first-name> #Gourav


Explanation: touch creates an empty file if it does not exist (or updates modification time if it exists).

Add the line This is my first line into that file without using an editor
(You can overwrite or append. Since it’s empty, both work. Use > to write.)

echo 'This is my first line' > /tmp/<first-name>


Explanation: echo 'text' prints the text. > redirects that output into the file — creating or overwriting the file contents.

Append another line this is a additional content without overwriting

echo 'this is a additional content' >> /tmp/<first-name>


Explanation: >> appends to the file (adds content to the end) — it will not overwrite existing content.

Create a new file named <last-name> with some content (no editor)

echo '<last-name> is my last name' > /tmp/<last-name> #Sharma


Explanation: writes that sentence into /tmp/<last-name> (creates file). Replace <last-name> in both places.

Insert a line at the beginning of the <last-name> file (no editor)
We’ll create a temporary file that has the new first line, then the old file content, then move it back.

# create a temp file with the new first line, then the original contents
( echo 'this is line at the beginning' ; cat /tmp/<last-name> ) > /tmp/<last-name>.tmp && mv /tmp/<last-name>.tmp /tmp/<last-name>


Explanation:

( echo '...'; cat /tmp/<last-name> ) runs two commands in a subshell: prints the new line, then prints the existing file content.

The combined output is redirected > into /tmp/<last-name>.tmp.

&& mv ... renames the temp file back to the original name only if the previous command succeeded. This effectively prepends the new line.

Add 8–10 more lines to the same file
Use a here-document to append many lines easily:

cat >> /tmp/<last-name> <<'EOF'
line 1: extra
line 2: extra
line 3: extra
line 4: extra
line 5: extra
line 6: extra
line 7: extra
line 8: extra
EOF


Explanation: cat >> file <<'EOF' reads the block until EOF and appends it to the file. You can put 8–10 lines in that block.

Commands to show parts of the file

Assume file is /tmp/<last-name>.

Top 5 lines:

head -n 5 /tmp/<last-name>


Bottom 2 lines:

tail -n 2 /tmp/<last-name>


Only the 6th line (without using sed):
Option A (fast, simple):

head -n 6 /tmp/<last-name> | tail -n 1


Option B (using awk):

awk 'NR==6{print; exit}' /tmp/<last-name>


Explanation: head -n 6 takes first 6 lines, tail -n 1 prints the last of those → line 6. awk prints the record where line number equals 6.

Lines 3–8:
Using awk:

awk 'NR>=3 && NR<=8{print}' /tmp/<last-name>


Or with head|tail:

head -n 8 /tmp/<last-name> | tail -n +3


Explanation: awk filters by record number. head -n 8 keeps first 8 lines; tail -n +3 prints from line 3 onward from that output.

Listings of /tmp

List all content including hidden files:

ls -la /tmp


Explanation: -l long listing (permissions, owner, size, time), -a includes dotfiles.

List only files (not directories) in /tmp (one-line example):

find /tmp -maxdepth 1 -type f -printf '%f\n'


Explanation: find searches /tmp with -maxdepth 1 (only top level), -type f filters regular files, -printf '%f\n' prints only the filename portion.

List only directories in /tmp:

find /tmp -maxdepth 1 -mindepth 1 -type d -printf '%f\n'


Explanation: -mindepth 1 excludes /tmp itself, -type d filters directories.

(Alternative, simpler but less precise: ls -p /tmp | grep '/$' — lists directories by trailing slash, but find is more robust.)

Copy <last-name> into /tmp/dir2 with the same name

cp /tmp/<last-name> /tmp/dir2/


Explanation: cp source dest_dir/ copies file keeping same basename.

Copy <last-name> into /tmp/dir2 with different name last-name.copy

cp /tmp/<last-name> /tmp/dir2/<last-name>.copy


Explanation: Provide destination filename explicitly.

Rename (mv) the <first-name> file to a different name at same location

mv /tmp/<first-name> /tmp/<new-name>


Explanation: mv moves or renames. This changes the filename but keeps it in /tmp.

Move the <last-name> file to /tmp/dir1

mv /tmp/<last-name> /tmp/dir1/


Explanation: This removes file from /tmp and places it in /tmp/dir1. If a file with same name exists in target, it will be overwritten — use mv -i to prompt.

Clear the content of /tmp/dir2/<last-name>.copy so it becomes zero bytes (no empty line)

> /tmp/dir2/<last-name>.copy


or

truncate -s 0 /tmp/dir2/<last-name>.copy


Explanation: > file redirects nothing into the file, truncating it to zero length (completely empty). truncate -s 0 also sets size to zero. Both remove all content, so the file contains nothing — no newline, no whitespace.

Delete the file /tmp/dir2/<last-name>.copy

rm /tmp/dir2/<last-name>.copy


Explanation: rm removes the file from the filesystem.