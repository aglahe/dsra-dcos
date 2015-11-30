## Description:

Currently setup to start a Kafka 0.9.0.0 Broker

#### Runtime options:

None.

#### Envrionment Variables

__BROKER_ID__: A non-negative integer

__CLUSTER_NAME__: Name used in Zookeeper ZNode, helps keep it off the root znode 

__ZK_IPS__:  comma separated list of zookeeper IPS, e.g. zk01:2181,zk02:2181,zk03:2181,zk04:2181,zk05:2181

__ADVERTISED_HOST_NAME__:  Optional hostname, if not using --net=HOST in the docker run command

#### Volumes:

/data/kafka: where the broker stores it's log information

#### Ports:

__9092__: default kafka port

__9999__: JMX Port

#### Command Line examples
```
* sudo docker run --name kafka --restart on-failure:5 --log-driver=journald
 -e BROKER_ID=1 \
 -e CLUSTER_NAME=dsra \
 -e ZK_IPS=zk01:2181,zk02:2181,zk03:2181,zk04:2181,zk05:2181 \
 -p 9092:9092 -p 9999:9999 aarongdocker/kafka
```

#### Example Broker ID, using the last octet of the IP:
```
BROKER_ID=`/usr/bin/ifconfig bond0 | /usr/bin/sed -n 2p | /usr/bin/awk '{ print $2 }' | cut -d . -f 4`
```
