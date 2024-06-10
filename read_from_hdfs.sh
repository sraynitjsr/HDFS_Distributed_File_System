#!/bin/bash

POD_NAME="ndl-hdfs-datanode-0"
SRC_PATH="/tmp/hdfs/data"

COMMAND="hdfs dfs -cat \"$SRC_PATH\""

kubectl exec -it "$POD_NAME" -- bash -c "$COMMAND"

if [ $? -eq 0 ]; then
    echo "Data read successfully from $SRC_PATH"
else
    echo "Error: Failed to read data from $SRC_PATH"
fi
