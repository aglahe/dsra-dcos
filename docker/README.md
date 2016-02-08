#Doing Docker

##Docker Data Container Setup
from *https://docs.docker.com/engine/userguide/containers/dockervolumes/*

For both HDFS and Kafka we make sure of two conatiners on each node:

 1. one for data
 2. one for running the service

The one for data uses the Volume command from the  [Dockerfile](https://github.com/aglahe/dsra-dcos/blob/master/docker/kafka/Dockerfile)

```
VOLUME ["/data/kafka"]

```
###Example Unit File: 
```
[Unit]
Description=kafka
After=docker.service
Requires=docker.service

[Service]
ExecStartPre=-/usr/bin/docker kill %p
ExecStartPre=/usr/bin/docker pull aarongdocker/kafka
ExecStartPre=-/usr/bin/docker create --name kafka-data aarongdocker/kafka /bin/true
ExecStartPre=-/usr/bin/docker rm -v %p
ExecStart=/usr/bin/bash -c "/usr/bin/docker run --name %p --restart on-failure:5 --log-driver=journald \
 --volumes-from kafka-data \
 -e BROKER_ID=`/usr/bin/ifconfig bond0 | /usr/bin/sed -n 2p | /usr/bin/awk '{ print $2 }' | cut -d . -f 4` \
 -e DELETE_TOPIC_ENABLE=true \
 -e CLUSTER_NAME=dsra \
 -e ZK_IPS=r105u01.dsra.local:2181,r105u03.dsra.local:2181,r105u05.dsra.local:2181,r105u07.dsra.local:2181,r105u09.dsra.local:2181 \
 -e ADVERTISED_HOST_NAME=%H.dsra.local \
 -p 9092:9092 -p 9999:9999 aarongdocker/kafka"
ExecStop=/usr/bin/docker stop %p
TimeoutStartSec=900s

[X-Fleet]
Global=true
MachineMetadata=role=worker
```
 
From our example service file above,  In our services files, you'll see a couple of lines:

 1. ExecStartPre=-/usr/bin/docker create --name kafka-data aarongdocker/kafka /bin/true
 2. ExecStart=/usr/bin/bash -c "/usr/bin/docker run --name %p --restart on-failure:5 --log-driver=journald \
 --volumes-from kafka-data \


The 1st line tries and create a docker container..but doesn't run it (the *-* at the start of line 1 tells fleet it can continue even if that command fails). The **--volumes-from kafka-data** tell the 2nd conatiner to *link* to volumes that are contained in the container with that name (in our example *kafka-data*).

##Docker Notes..little notes that made my life easier

###Remove docker containers that you don't want anymore
```
$ pssh -vi -l core -h clusters/workers "docker rm -v \$(docker ps -a | grep "XXXXXXX" | cut -d' ' -f1)"
```
where "XXXXXX" is used to filter down what you want.  the *cut -d' ' -f1* part gets the container ID

