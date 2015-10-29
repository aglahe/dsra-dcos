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

# Read the 1st arg, and based upon one of the five: format or bootstrap or start the particular service
# NN and ZKFC stick together
case "$1" in
  active)
    if [[ ! -a /data/hdfs/nn/current/VERSION ]]; then
      echo "Format Namenode.."
      $HADOOP_PREFIX/bin/hdfs namenode -format

      echo "Format Zookeeper for Fast failover.."
      $HADOOP_PREFIX/bin/hdfs zkfc -formatZK
    fi
    $HADOOP_PREFIX/sbin/hadoop-daemon.sh start zkfc
    $HADOOP_PREFIX/bin/hdfs namenode
    ;;
  standby)
    if [[ ! -a /data/hdfs/nn/current/VERSION ]]; then
      echo "Bootstrap Standby Namenode.."
      $HADOOP_PREFIX/bin/hdfs namenode -bootstrapStandby
    fi
    $HADOOP_PREFIX/sbin/hadoop-daemon.sh start zkfc
    $HADOOP_PREFIX/bin/hdfs namenode
    ;;
  zkfc)
    $HADOOP_PREFIX/bin/hdfs zkfc
    ;;
  journalnode)
    $HADOOP_PREFIX/bin/hdfs journalnode
    ;;
  datanode)
    $HADOOP_PREFIX/bin/hdfs datanode
    ;;
  bash)
    /bin/bash
    ;;
  *)
    echo $"Usage: {active|standby|zkfc|journalnode|datanode|bash}"
    eval $*
esac
