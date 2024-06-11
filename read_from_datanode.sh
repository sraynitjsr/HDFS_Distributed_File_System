#!/bin/bash

NAMESPACE="ndl"
FILE_PATH="/tmp/data.txt"

start_loop_time=$(date +%s)

pod_names=( $(kubectl get pods -n "$NAMESPACE" --no-headers | awk '/datanode/ {print $1}') )

for pod_name in "${pod_names[@]}"; do
    start_time=$(date +%s)
    kubectl exec -it -n "$NAMESPACE" "$pod_name" -- /bin/bash -c "cat $FILE_PATH" > "$(pwd)/data_${pod_name}.txt"
    end_time=$(date +%s)
    total_time=$((end_time - start_time))
    
    if [ $? -eq 0 ]; then
        echo "Successfully copied $FILE_PATH from $pod_name to $(pwd) in $total_time seconds"
    else
        echo "Failed to copy $FILE_PATH from $pod_name"
    fi
done

end_loop_time=$(date +%s)
total_loop_time=$((end_loop_time - start_loop_time))
echo "Overall time taken for the loop: $total_loop_time seconds"
