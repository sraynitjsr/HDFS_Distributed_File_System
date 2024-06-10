#!/bin/bash

POD_NAME="ndl-hdfs-datanode-0"
DATA="Hello, world!"
DEST_PATH="/tmp/hdfs/data"

COMMAND="echo \"$DATA\" | hdfs dfs -put - \"$DEST_PATH\""

kubectl exec -it "$POD_NAME" -- bash -c "$COMMAND"

if [ $? -eq 0 ]; then
    echo "Data written successfully to $DEST_PATH"
else
    echo "Error: Failed to write data to $DEST_PATH"
fi
