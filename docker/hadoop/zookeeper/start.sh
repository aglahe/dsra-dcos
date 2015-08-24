#!/bin/bash

if [[ -z "${ZK_ID}" || -z "${ZK_SERVERS}" ]]; then
	echo "Please set ZK_ID and ZK_SERVERS environment variables first."
	exit 1
fi

# Setup defaults
echo "maxClientCnxns=50" >> /usr/local/zookeeper/conf/zoo.cfg
echo "tickTime=2000"  >> /usr/local/zookeeper/conf/zoo.cfg
echo "initLimit=10"  >> /usr/local/zookeeper/conf/zoo.cfg
echo "syncLimit=5"  >> /usr/local/zookeeper/conf/zoo.cfg
echo "clientPort=2181"   >> /usr/local/zookeeper/conf/zoo.cfg
echo "dataDir=/var/lib/zookeeper"  >> /usr/local/zookeeper/conf/zoo.cfg
echo "dataLogDir=/var/lib/zookeeper"  >> /usr/local/zookeeper/conf/zoo.cfg

# Store the id
echo $ZK_ID > /var/lib/zookeeper/myid

# add server list if given
if [ ! -z "$ZK_SERVERS" ]; then
  # explode into array
  IFS=',' read -a arr <<< "$ZK_SERVERS"
  # if the count is even
  if [ $(expr ${#arr[@]} % 2) == 0 ]; then
    echo "Number of servers must be odd."
    exit 1
  else # odd count
    # remove current server entries
    sed '/^server\.[0-9]*=.*$/d' -i /usr/local/zookeeper/conf/zoo.cfg
    # add entries from array
    for i in ${!arr[@]}; do
      #echo "$i ${arr[i]}"
      echo "server.$(expr 1 + $i)=${arr[i]}" >> /usr/local/zookeeper/conf/zoo.cfg
    done
  fi
fi

#Start zookeeper
/usr/local/zookeeper/bin/zkServer.sh start-foreground
