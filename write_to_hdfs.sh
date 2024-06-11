#!/bin/bash

NAMESPACE="ndl"
TEMP_FILE="/tmp/data.txt"

function write_data_to_pod {
  local pod_name="$1"

  start_time=$(date +%s.%N)

  for i in {1..100}; do
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    data="Hello World $i - $current_time"
    kubectl exec -it $pod_name -n $NAMESPACE -- /bin/bash -c "echo \"$data\" >> $TEMP_FILE"
  done

  end_time=$(date +%s.%N)

  total_time=$(echo "$end_time" "$start_time" | awk '{print $1 - $2}')

  echo "Total time spent writing data to '$pod_name': $total_time seconds"
}

pod_names=( $(kubectl get pods -n "$NAMESPACE" --no-headers | grep datanode | awk '{print $1}') )

if [ ${#pod_names[@]} -eq 0 ]; then
  echo "Error: No DataNode pods found in namespace '$NAMESPACE'."
  exit 1
fi

overall_start_time=$(date +%s.%N)

for pod in "${pod_names[@]}"; do
  echo "Writing data to pod: $pod"
  write_data_to_pod "$pod"
done

overall_end_time=$(date +%s.%N)

overall_time=$(echo "$end_time" "$overall_start_time" | awk '{print $1 - $2}')

echo "** Overall time spent writing data to all pods: $overall_time seconds **"
