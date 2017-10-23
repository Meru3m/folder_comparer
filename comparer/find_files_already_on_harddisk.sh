#
# Run example: 
# ./find_files_already_on_harddisk.sh root/child1 root/child2
#
#!/bin/bash

dir_son1=$1
dir_son2=$2

find "$dir_son1" -type f -exec shasum {} \; > "/tmp/files1-deleteme.txt"
find "$dir_son2" -type f -exec shasum {} \; > "/tmp/files2-deleteme.txt"

echo -e "#################### Files contained only in $dir_son1 ####################\n"
while IFS='' read -r line || [[ -n "$line" ]]; do
    hash=$(echo "$line"|cut -f1 -d' ')
    cat "/tmp/files2-deleteme.txt" | grep "$hash" 1> /dev/null
    if [ "$?" -eq "1" ]; then
        echo "$line" | cut -c43- 
    fi
done < "/tmp/files1-deleteme.txt"

echo -e "\n\n#################### Files contained only in $dir_son2 ####################\n"
while IFS='' read -r line || [[ -n "$line" ]]; do
    hash=$(echo "$line"|cut -f1 -d' ')
    cat "/tmp/files1-deleteme.txt" | grep "$hash" 1> /dev/null
    if [ "$?" -eq "1" ]; then
        echo "$line" | cut -c43- 
    fi
done < "/tmp/files2-deleteme.txt"

rm "/tmp/files1-deleteme.txt" "/tmp/files2-deleteme.txt"