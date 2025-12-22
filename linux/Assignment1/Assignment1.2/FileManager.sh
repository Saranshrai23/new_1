#!/bin/bash
#set -x

action=$1
path=$2
name=$3
arg4=$4
arg5=$5

addDir() {
    mkdir -p "$path/$name"
    echo "Directory created: $path/$name"
}

deleteDir() {
    if [ -d "$path/$name" ]; then
        rm -r "$path/$name"
        echo "Directory deleted: $path/$name"
    else
        echo "Directory not found."
    fi
}

listFiles() {
    find "$path" -maxdepth 1 -type f
}

listDirs() {
    find "$path" -maxdepth 1 -type d
}

listAll() {
    ls -l "$path"
}

addFile() {
    if [ -n "$arg4" ]; then
        echo "$arg4" > "$path/$name"
    else
        touch "$path/$name"
    fi
    echo "File created: $path/$name"
}

addContentToFile() {
    echo "$arg4" >> "$path/$name"
    echo "Content added at end."
}

addContentToFileBegining() {
    tmpfile=$(mktemp)
    echo "$arg4" > "$tmpfile"
    cat "$path/$name" >> "$tmpfile"
    mv "$tmpfile" "$path/$name"
    echo "Content added at beginning."
}

showFileBeginingContent() {
    head -n "$arg4" "$path/$name"
}

showFileEndContent() {
    tail -n "$arg4" "$path/$name"
}

showFileContentAtLine() {
    head -n "$arg4" "$path/$name" | tail -n 1
}

showFileContentForLineRange() {
    start=$arg4
    end=$arg5
    total=$((end-start+1))
    head -n "$end" "$path/$name" | tail -n "$total"
}

moveFile() {
    mv "$path/$name" "$arg4"
    echo "File moved from $path/$name to $arg4"
}

copyFile() {
    cp "$path/$name" "$arg4"
    echo "File copied from $path/$name to $arg4"
}

clearFileContent() {
    > "$path/$name"
    echo "File content cleared."
}

deleteFile() {
    rm -f "$path/$name"
    echo "File deleted: $path/$name"
}

case $action in

    addDir) addDir ;;
    deleteDir) deleteDir ;;
    listFiles) listFiles ;;
    listDirs) listDirs ;;
    listAll) listAll ;;

    addFile) addFile ;;
    addContentToFile) addContentToFile ;;
    addContentToFileBegining) addContentToFileBegining ;;

    showFileBeginingContent) showFileBeginingContent ;;
    showFileEndContent) showFileEndContent ;;
    showFileContentAtLine) showFileContentAtLine ;;
    showFileContentForLineRange) showFileContentForLineRange ;;

    moveFile) moveFile ;;
    copyFile) copyFile ;;
    clearFileContent) clearFileContent ;;
    deleteFile) deleteFile ;;

    *) echo "Invalid command" ;;

esac


