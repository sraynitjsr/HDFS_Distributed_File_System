#!/bin/bash

# Command 1: List contents of a directory in HDFS
echo "hadoop fs -ls /path/to/directory"

# Command 2: Create a new directory in HDFS
echo "hadoop fs -mkdir /path/to/new_directory"

# Command 3: Copy a file or directory from the local filesystem to HDFS
echo "hadoop fs -put /path/to/local/file /path/to/hdfs/directory"

# Command 4: Copy a file or directory from HDFS to the local filesystem
echo "hadoop fs -get /path/to/hdfs/file /path/to/local/directory"

# Command 5: Delete a file in HDFS
echo "hadoop fs -rm /path/to/file"

# Command 6: Delete an empty directory in HDFS
echo "hadoop fs -rmdir /path/to/empty_directory"

# Command 7: Copy files from the local filesystem to HDFS (alternative syntax)
echo "hadoop fs -copyFromLocal /path/to/local/file /path/to/hdfs/directory"

# Command 8: Copy files from HDFS to the local filesystem (alternative syntax)
echo "hadoop fs -copyToLocal /path/to/hdfs/file /path/to/local/directory"
