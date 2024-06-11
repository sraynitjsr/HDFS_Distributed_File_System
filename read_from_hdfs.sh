#!/bin/bash

NAMESPACE="ndl"
DATANODE_POD_NAME="ndl-hdfs-datanode-0"
HDFS_FILE="/tmp/data.txt"
LOCAL_FILE="downloaded_data.txt"

file_exists=$(kubectl exec -n $NAMESPACE $DATANODE_POD_NAME -- /bin/bash -c "test -f $HDFS_FILE && echo yes || echo no")

if [ "$file_exists" == "yes" ]; then
  rm -rf $LOCAL_FILE
  start_time=$(date +%s.%N)
  kubectl cp -n $NAMESPACE $DATANODE_POD_NAME:$HDFS_FILE $LOCAL_FILE
  end_time=$(date +%s.%N)
  total_time=$(echo "$end_time" "$start_time" | awk '{print $1 - $2}')
  echo "File '$HDFS_FILE' copied successfully to '$LOCAL_FILE' in $total_time seconds (approximately)"
else
  echo "File '$HDFS_FILE' does not exist on the DataNode pod."
fi
