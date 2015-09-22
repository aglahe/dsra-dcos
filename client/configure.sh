#!/usr/bin/env bash

# Setup Envs to be used in this script as default
export CLUSTER_NAME=dsra
export NNODE1_IP=r105u01.dsra.local
export NNODE2_IP=r105u03.dsra.local
export ZK_IPS=r105u01.dsra.local:2181,r105u03.dsra.local:2181,r105u05.dsra.local:2181,r105u07.dsra.local:2181,r105u09.dsra.local:2181
export JN_IPS=r105u01.dsra.local:8485;r105u03.dsra.local:8485;r105u05.dsra.local:8485;r105u07.dsra.local:8485;r105u09.dsra.local:8485
export FLEETCTL_ENDPOINT="http://r105u01.dsra.local:2379,http://r105u03.dsra.local:2379,http://r105u05.dsra.local:2379,http://r105u07.dsra.local:2379,http://r105u09.dsra.local:2379"
export ETCDCTL_ENDPOINT="http://r105u01.dsra.local:2379,http://r105u03.dsra.local:2379,http://r105u05.dsra.local:2379,http://r105u07.dsra.local:2379,http://r105u09.dsra.local:2379"

 # Replace all the variables in hdfs-site.xml
 sudo sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /tmp/hdfs-site.xml.template \
 | sed "s/NNODE1_IP/$NNODE1_IP/" \
 | sed "s/NNODE2_IP/$NNODE2_IP/" \
 | sed "s/JNODES/$JNODES/" \
 > /usr/local/hadoop/etc/hadoop/hdfs-site.xml

 # Replace all the variables in core-site.xml
 sudo sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /tmp/core-site.xml.template \
 | sed "s/ZK_IPS/$ZK_IPS/" \
 > /usr/local/hadoop/etc/hadoop/core-site.xml

# Now get fleetctl and etcdctl setup
sudo echo "export FLEETCTL_ENDPOINT=$FLEETCTL_ENDPOINT" >> /etc/profile.d/fleet.sh
sudo echo "export ETCDCTL_ENDPOINT=$ETCDCTL_ENDPOINT" >> /etc/profile.d/etcd.sh
