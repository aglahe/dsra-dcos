#!/bin/bash

# Check for cluster name
if [ -z $CLUSTER_NAME ]; then
  CLUSTER_NAME="cluster"
  export CLUSTER_NAME
fi

# make sure we have everyrthing
if [ -z $NNODE1_IP ] || [ -z $NNODE2_IP ]  || [ -z $ZK_IPS ] || [ -z $JN_IPS ]; then
  echo NNODE1_IP, NNODE2_IP, JN_IPS and ZK_IPS needs to be set as environment addresses to be able to run.
  exit;
fi

#  Let see if we are doing an action: formatting or bootstrap; or just running a service
if [[ $# -gt 1 ]]; then
  action=$1
  service=$2
elif [[ $# -eq 1 ]]; then
  service=$1
else
  echo $"Usage: format|bootstrap with namenode or journalnode|namenode|datanode"
  service=bash
fi

# convert the commas to semicolons..if they exist
JNODES=$(echo $JN_IPS | tr "," ";")

# Replace all the variables in hdfs-site.xml
sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/hdfs-site.xml.template \
| sed "s/NNODE1_IP/$NNODE1_IP/" \
| sed "s/NNODE2_IP/$NNODE2_IP/" \
| sed "s/ZK_IPS/$ZK_IPS/" \
| sed "s/JNODES/$JNODES/" \
> /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Replace all the variables in core-site.xml
sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

# If there is a format action
if [[ $action = "format" ]]; then
  read -p "Are you sure to format this hdfs volume? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    $HADOOP_PREFIX/bin/hdfs namenode -format

    echo "Format Zookeeper for Fast failover.."
    $HADOOP_PREFIX/bin/hdfs zkfc -formatZK

    exit;
  fi
  exit;
fi

# If there is a bootstrap action
if [[ $action = "bootstrap" ]]; then
  read -p "Are you sure to bootstrap this hdfs namenode? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    $HADOOP_PREFIX/bin/hdfs namenode -bootstrapStandby
    exit;
  fi
  exit;
fi

# Run a journalnode, datanode or namenode
if [[ $service != "bash" ]]; then
  echo $HADOOP_PREFIX/bin/hdfs start $server

  $HADOOP_PREFIX/bin/hdfs start $server
  if [[ $service = "namenode" ]]; then
    $HADOOP_PREFIX/bin/hdfs start zkfc
  fi
fi
