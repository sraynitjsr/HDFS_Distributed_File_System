#!/bin/bash

NAMESPACE="ndl"
TEMP_FILE="/tmp/data.txt"

function write_data_to_pod {
  local pod_name="$1"
  start_time=$(date +%s.%N)
  for i in {1..10}; do
    kubectl exec -it "$pod_name" -n "$NAMESPACE" -- /bin/bash -c "echo 'Hello World $i - $(date "+%Y-%m-%d %H:%M:%S")' >> $TEMP_FILE"
  done
  end_time=$(date +%s.%N)
  echo "Total time spent writing data to '$pod_name': $(echo "$end_time $start_time" | awk '{print $1 - $2}') seconds"
}

pod_names=( $(kubectl get pods -n "$NAMESPACE" --no-headers | awk '/datanode/ {print $1}') )

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

echo "** Overall time spent writing data to all pods: $(echo "$overall_end_time $overall_start_time" | awk '{print $1 - $2}') seconds **"
