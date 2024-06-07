#!/bin/bash

# Step 1: Install Java
sudo apt update
sudo apt install -y default-jdk

# Step 2: Download and Extract Hadoop
wget https://downloads.apache.org/hadoop/common/hadoop-X.Y.Z/hadoop-X.Y.Z.tar.gz
tar -xzvf hadoop-X.Y.Z.tar.gz
sudo mv hadoop-X.Y.Z /usr/local/hadoop

# Step 3: Configure Environment Variables
echo 'export HADOOP_HOME=/usr/local/hadoop' >> ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> ~/.bashrc
source ~/.bashrc

# Step 4: Configure Hadoop
cd /usr/local/hadoop/etc/hadoop
cp mapred-site.xml.template mapred-site.xml
cp core-site.xml.template core-site.xml
cp hdfs-site.xml.template hdfs-site.xml

# Step 5: Format HDFS Namenode
hdfs namenode -format

# Step 6: Start Hadoop Services
start-all.sh
