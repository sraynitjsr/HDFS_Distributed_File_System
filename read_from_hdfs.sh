#!/bin/bash

NAMESPACE="ndl"
HDFS_FILE="/tmp/data.txt"

function read_data_from_pod {
  local pod_name="$1"

  if kubectl exec -n "$NAMESPACE" "$pod_name" -- test -f "$HDFS_FILE"; then
    local start_time=$(date +%s.%N)
    local local_file="downloaded_data_${pod_sequence_number}.txt"
    kubectl cp -n "$NAMESPACE" "$pod_name:$HDFS_FILE" "$local_file"
    local end_time=$(date +%s.%N)
    local read_time=$(echo "$end_time" "$start_time" | awk '{print $1 - $2}')
    echo "File '$HDFS_FILE' copied from '$pod_name' to '$local_file' in $read_time seconds (approximately)"
    return $read_time
  else
    echo "File '$HDFS_FILE' does not exist on the DataNode pod '$pod_name'."
    return 0
  fi
}

pod_names=( $(kubectl get pods -n "$NAMESPACE" --no-headers | grep datanode | awk '{print $1}') )

if [[ ${#pod_names[@]} -eq 0 ]]; then
  echo "Error: No DataNode pods found in namespace '$NAMESPACE'."
  exit 1
fi

read_times=()

pod_sequence_number=1

overall_start_time=$(date +%s.%N)

for pod in "${pod_names[@]}"; do
  echo "Reading data from pod: $pod"
  read_time=$(read_data_from_pod "$pod")
  read_times[((pod_sequence_number-1))]=$read_time
  ((pod_sequence_number++))
done

overall_end_time=$(date +%s.%N)

overall_time=$(echo "$overall_end_time" "$overall_start_time" | awk '{print $1 - $2}')

if [[ ${#read_times[@]} -gt 0 ]]; then
  echo ""
  echo "** Individual Pod Read Times (seconds):"
  for ((i=0; i<${#pod_names[@]}; i++)); do
    pod="${pod_names[$i]}"
    time=${read_times[$i]}
    if [[ ! -z "$time" ]]; then
      echo "- Pod: $pod - Time: $time"
    fi
  done
fi

echo "** Overall time spent reading data from all pods: $overall_time seconds **"
