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

# Read the 1st arg, and based upon one of the five: format or bootstrap or start the particular service
# NN and ZKFC stick together
case "$1" in
  format)
    $HADOOP_PREFIX/bin/hdfs namenode -format $CLUSTER_NAME

    # Test for zookeeper before doing this
    if [echo ruok | nc $(echo $ZK_IPS | cut -d',' -f1 | cut -d':' -f1 ) 2181]
      $HADOOP_PREFIX/bin/hdfs zkfc -formatZK
    fi
    ;;
  bootstrap)
    $HADOOP_PREFIX/bin/hdfs namenode -bootstrapStandby
    ;;
  journalnode)
    $HADOOP_PREFIX/sbin/hadoop-daemon.sh start journalnode
    ;;
  namenode)
    $HADOOP_PREFIX/sbin/hadoop-daemon.sh start namenode

    # Test for zookeeper before doing this
    if [echo ruok | nc $(echo $ZK_IPS | cut -d',' -f1 | cut -d':' -f1 ) 2181]
      $HADOOP_PREFIX/sbin/hadoop-daemon.sh start zkfc
    fi
    ;;
  datanode)
    $HADOOP_PREFIX/sbin/hadoop-daemon.sh start datanode
    ;;
  *)
    echo $"Usage: {format|bootstrap|journalnode|namenode|datanode}"
    eval $*
esac
