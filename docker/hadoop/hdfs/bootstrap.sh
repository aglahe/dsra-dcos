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
  echo $"Usage: {bootstrap namenode|namenode|journalnode||datanode}"
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

# If we are staring a namenode, lets see if we need to format it for the 1st time
if [[ $service = "namenode" ]]; then
  if [[ ! -a /data/hdfs/nn/current/VERSION ]]; then
    echo "Format Namenode.."
    $HADOOP_PREFIX/bin/hdfs namenode -format

    echo "Format Zookeeper for Fast failover.."
    $HADOOP_PREFIX/bin/hdfs zkfc -formatZK
  fi
fi

# If there is an action, we are bootstrapping
if [[ $action = "bootstrap" ]]; then
  # If we are bootstraping a namenode, lets see if we need to first..
  if [[ ! -a /data/hdfs/nn/current/VERSION ]]; then
    echo "Bootstrap Namenode.."
    $HADOOP_PREFIX/bin/hdfs namenode -bootstrapStandby
  fi
else
  echo $"Usage: {bootstrap namenode|namenode|journalnode||datanode}"
fi

# Run a journalnode, datanode or namenode
if [[ $service != "bash" ]]; then
  echo $HADOOP_PREFIX/bin/hdfs start $server

  $HADOOP_PREFIX/bin/hdfs start $server
  if [[ $service = "namenode" ]]; then
    $HADOOP_PREFIX/bin/hdfs start zkfc
  fi
else
  /bin/bash
fi
