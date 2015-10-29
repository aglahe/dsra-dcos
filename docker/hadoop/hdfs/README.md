## Description:

Meant to standup a Hadoop 2.7.1 HDFS HA on multiple machines inside Docker containers.  On the "active" namenode, the 1st time it starts up, it will format the namenode as well as format the ZK for failover.  The "standby" namenode will bootStrapStandby.  

#### Runtime options:

* __acitve__:  This is meant to start the 1st namenode.  This will also start a zkfc service.
* __standby__:  This is meant to start the 2nd namenode, and boot starp of an already formatted/running namenode. This will also start a zkfc service.
* __zkfc__:  If you choose to start the zkfc in as a separate service
* __journalnode__:  starts a journalnode
* __datanode__:  starts a datanode
* __bash__:  allows you to jump in and check things out

#### Envrionment Variables

__CLUSTER_NAME__:  the HDFS URI default filesystem name

__NNODE1_IP__: Namenode #1 IP/hostname

__NNODE2_IP__:  Namenode #2 IP/hostname

__NNODE_ID__:  the id of the particular namenode either: *nn1* or *nn2*

__JN_IPS__: comma separated list of journal node IPS, e.g jn01:8485,jn02:8485,jn03:8485,jn04:8485,jn05:8485

__ZK_IPS__:  comma separated list of zookeeper IPS, e.g. zk01:2181,zk02:2181,zk03:2181,zk04:2181,zk05:2181

#### Volumes:

/data/hdfs/nn:  inside the container, where the fsimage/namenode metadata exists

/data/hdfs/jn:  inside the container, where the journal node keeps the edits

/data/jdfs/dn: inside the container, where the datanode keeps the blocks

#### Command Line examples

To see examples of how to start, please see the startup-cmdlines files one directory "up."

* sudo docker run -it --name nn01 --net=host --env-file hdfs-envs --env NNODE_ID=nn1 hdfs active
