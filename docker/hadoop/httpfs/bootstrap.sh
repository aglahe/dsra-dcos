#!/bin/bash

# make sure we have everyrthing
if [ -z $CLUSTER_NAME ] || [ -z $NNODE1_IP ] || [ -z $NNODE2_IP ]  || [ -z $ZK_IPS ] || [ -z $JN_IPS ]; then
  echo CLUSTER_NAME, NNODE1_IP, NNODE2_IP, JN_IPS and ZK_IPS needs to be set as environment addresses to be able to run.
  exit;
fi

# convert the commas to semicolons..if they exist
JNODES=$(echo $JN_IPS | tr "," ";")

# Replace all the variables in hdfs-site.xml
sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/hdfs-site.xml.template \
| sed "s/NNODE1_IP/$NNODE1_IP/" \
| sed "s/NNODE2_IP/$NNODE2_IP/" \
| sed "s/JNODES/$JNODES/" \
> /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Replace all the variables in core-site.xml
sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/core-site.xml.template \
| sed "s/ZK_IPS/$ZK_IPS/" \
> /usr/local/hadoop/etc/hadoop/core-site.xml

# Read the 1st arg and execute
case "$1" in
  start)
    $HADOOP_PREFIX/sbin/httpfs.sh run
    ;;
  bash)
    /bin/bash
    ;;
  *)
    echo $"Usage: {httpfs|bash}"
    eval $*
esac
