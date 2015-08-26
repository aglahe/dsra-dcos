#!/bin/bash

if [ -z $CLUSTER_NAME ]; then
  CLUSTER_NAME="cluster"
  export CLUSTER_NAME
fi

if [ -z $NNODE1_IP ] || [ -z $NNODE2_IP ]  || [ -z $ZK_IPS ] || [ -z $JN_IPS ]; then
  echo NNODE1_IP, NNODE2_IP, JN_IPS and ZK_IPS needs to be set as environment addresses to be able to run.
  exit;
fi

JNODES=$(echo $JN_IPS | tr "," ";")

sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/hdfs-site.xml.template \
| sed "s/NNODE1_IP/$NNODE1_IP/" \
| sed "s/NNODE2_IP/$NNODE2_IP/" \
| sed "s/ZKNODES/$ZK_IPS/" \
| sed "s/JNODES/$JNODES/" \
> /usr/local/hadoop/etc/hadoop/hdfs-site.xml

sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml
