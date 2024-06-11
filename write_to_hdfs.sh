#!/bin/bash

NAMESPACE="ndl"
DATANODE_POD_NAME="ndl-hdfs-datanode-0"
TEMP_FILE="/tmp/data.txt"

start_time=$(date +%s.%N)

for i in {1..100}; do
  current_time=$(date "+%Y-%m-%d %H:%M:%S")
  data="Hello World $i - $current_time"
  kubectl exec -it $DATANODE_POD_NAME -n $NAMESPACE -- /bin/bash -c "echo \"$data\" >> $TEMP_FILE"
done

end_time=$(date +%s.%N)

total_time=$(echo "$end_time" "$start_time" | awk '{print $1 - $2}')

echo "Total time spent writing data: $total_time seconds (approximately)"
