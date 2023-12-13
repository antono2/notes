#!/bin/bash

### ABOUT
### Runs rsync, retrying on errors up to a maximum number of tries.
### Simply edit the rsync line in the script to whatever parameters you need.

# Trap interrupts and exit instead of continuing the loop
trap "echo Exited!; exit;" SIGINT SIGTERM

MAX_RETRIES=50
i=0

# Set the initial return value to failure
false

while [ $? -ne 0 -a $i -lt $MAX_RETRIES ]
do
 i=$(($i+1))
 # rsync -avz --progress --partial /rsync/source/folder backupuser@backup.destination.com:/rsync/destination/folder
# Note: from/path/ - without the path directory
#       from/path  - with    the path directory
 rsync -avzr --info=progress2 --partial "/home/anton/workspace/" "/media/anton/ADATA HD710 PRO/workspace"
done

if [ $i -eq $MAX_RETRIES ]
then
  echo "Hit maximum number of retries, giving up."
fi
