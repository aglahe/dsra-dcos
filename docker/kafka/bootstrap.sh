#!/bin/bash

# make sure we have everyrthing
if [ -z $CLUSTER_NAME ] || [ -z $ZK_IPS ]; then
  echo CLUSTER_NAME \(which becomes the ZK root\), ZK_IPS needs to be set as environment addresses to be able to run
  exit;
fi

# Set the Logs DIR
sed -r -i "s/(log.dirs)=(.*)/\1=\/data\/kafka/g" $KAFKA_HOME/config/server.properties

# Add the delete logs property if it is set, put it right after the log.dirs setting
if [ ! -z "$DELETE_TOPIC_ENABLE" ]; then
    echo "allow topic delete: $DELETE_TOPIC_ENABLE"
    sed -r -i "/(log.dirs)=/a delete.topic.enable=$DELETE_TOPIC_ENABLE" $KAFKA_HOME/config/server.properties
fi

# Set the ZK_IPS amd CLUSTER_NAME
sed -r -i "s/(zookeeper.connect)=(.*)/\1=$ZK_IPS\/$CLUSTER_NAME-kafka/g" $KAFKA_HOME/config/server.properties

# Set the broker Id, if not available create one, 1-100
if [[ -z $BROKER_ID ]]; then
    export BROKER_ID=$((RANDOM % 100)+1)
fi
sed -r -i "s/(broker.id)=(.*)/\1=$BROKER_ID/g" $KAFKA_HOME/config/server.properties

# Set the external host and port
if [ ! -z "$ADVERTISED_HOST_NAME" ]; then
    echo "advertised host: $ADVERTISED_HOST"
    sed -r -i "s/#(advertised.host.name)=(.*)/\1=$ADVERTISED_HOST_NAME/g" $KAFKA_HOME/config/server.properties
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

# Stolen from ches/docker-kafka to help enable JMX monitoring
if [ -z $KAFKA_JMX_OPTS ]; then
    KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote=true"
    KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
    KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Dcom.sun.management.jmxremote.ssl=false"
    KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT"
    KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Djava.rmi.server.hostname=${JAVA_RMI_SERVER_HOSTNAME:-$ADVERTISED_HOST_NAME} "
    export KAFKA_JMX_OPTS
fi

# Run Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
