#!/bin/bash

# make sure we have everyrthing
if [ -z $CLUSTER_NAME ] || [ -z $ZK_IPS ]; then
  echo CLUSTER_NAME \(which becomes the ZK root\), ZK_IPS needs to be set as environment addresses to be able to run
  exit;
fi

# Set the Logs DIR
sed -r -i "s/(log.dirs)=(.*)/\1=\/data\/kafka/g" $KAFKA_HOME/config/server.properties

# Set the ZK_IPS amd CLUSTER_NAME
sed -r -i "s/(zookeeper.connect)=(.*)/\1=$ZK_IPS\/$CLUSTER_NAME-kafka/g" $KAFKA_HOME/config/server.properties

# Set the broker Id, if not available create one
if [[ -z $BROKER_ID ]]; then
    export BROKER_ID=$RANDOM
fi
sed -r -i "s/(broker.id)=(.*)/\1=$BROKER_ID/g" $KAFKA_HOME/config/server.properties

# Set the external host and port
if [ ! -z "$ADVERTISED_HOST" ]; then
    echo "advertised host: $ADVERTISED_HOST"
    sed -r -i "s/#(advertised.host.name)=(.*)/\1=$ADVERTISED_HOST/g" $KAFKA_HOME/config/server.properties
fi
if [ ! -z "$ADVERTISED_PORT" ]; then
    echo "advertised port: $ADVERTISED_PORT"
    sed -r -i "s/#(advertised.port)=(.*)/\1=$ADVERTISED_PORT/g" $KAFKA_HOME/config/server.properties
fi

if [ ! -z "$LOG_RETENTION_HOURS" ]; then
    echo "log retention hours: $LOG_RETENTION_HOURS"
    sed -r -i "s/(log.retention.hours)=(.*)/\1=$LOG_RETENTION_HOURS/g" $KAFKA_HOME/config/server.properties
fi
if [ ! -z "$LOG_RETENTION_BYTES" ]; then
    echo "log retention bytes: $LOG_RETENTION_BYTES"
    sed -r -i "s/#(log.retention.bytes)=(.*)/\1=$LOG_RETENTION_BYTES/g" $KAFKA_HOME/config/server.properties
fi

if [ ! -z "$NUM_PARTITIONS" ]; then
    echo "default number of partition: $NUM_PARTITIONS"
    sed -r -i "s/(num.partitions)=(.*)/\1=$NUM_PARTITIONS/g" $KAFKA_HOME/config/server.properties
fi

# Run Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
