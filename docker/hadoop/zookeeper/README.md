## Description:

Meant to startup a zookeeper node

#### Runtime options:

* __bash__:  allows you to jump in and check things out

#### Envrionment Variables

__ZK_ID__:  the ID of this particular server

__ZK_SERVERS__:  comma separated list of zookeeper IPS, e.g. zk01:2181,zk02:2181,zk03:2181,zk04:2181,zk05:2181

#### Volumes:

/var/lib/zookeeper:  inside the container, where the data and logs exists
