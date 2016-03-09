#!/bin/bash

# Check for MESOS_ZK parameter
if [ -z ${MESOS_ZK+x} ]; then
  echo "Please supply at least a Zookeeper connection string!"
  exit 1
else
  ZK=$(echo ${MESOS_ZK//\//\\/})
fi

# Check for local ip address parameter
if [ -z ${LOCAL_IP+x} ]; then
  IP=$(nslookup `hostname -f` | tail -1 | head -2 | awk '{print $3}')
else
  IP="${LOCAL_IP}"
fi

# Check for EXTERNAL_DNS_SERVERS parameter
if [ -z ${MESOS_DNS_EXTERNAL_SERVERS+x} ]; then
  DNS_SERVERS="8.8.8.8"
else
  IFS=',' read -a dnshosts <<< "$MESOS_DNS_EXTERNAL_SERVERS"
  for index in "${!dnshosts[@]}"
  do
    DNS_SERVER_STRINGS[(index+1)]="\"${dnshosts[index]}\""
  done
  # Produce correct env variables for DNS servers
  IFS=','
  DNS_SERVERS="[${DNS_SERVER_STRINGS[*]}]"
fi

# Check for MESOS_IP_SOURCES parameter
if [ -z ${MESOS_IP_SOURCES+x} ]; then
  IP_SOURCES="[\"netinfo\", \"host\", \"mesos\"]"
else
  IFS=',' read -a ipsources <<< "$MESOS_IP_SOURCES"
  for index in "${!ipsources[@]}"
  do
    IP_SOURCES_STRINGS[(index+1)]="\"${ipsources[index]}\""
  done
  # Produce correct env variables for IP sources
  IFS=','
  IP_SOURCES="[${IP_SOURCES_STRINGS[*]}]"
fi

# Check for HTTP_PORT parameter
if [ -z ${MESOS_DNS_HTTP_PORT+x} ]; then
  PORT="8123"
else
  PORT="${MESOS_DNS_HTTP_PORT}"
fi

# Check for HTTP_ENABLED parameter
if [ -z ${MESOS_DNS_HTTP_ENABLED+x} ]; then
  HTTP_ENABLED="false"
else
  HTTP_ENABLED="${MESOS_DNS_HTTP_ENABLED}"
fi

# Check for REFRESH parameter
if [ -z ${MESOS_DNS_REFRESH+x} ]; then
  REFRESH="60"
else
  REFRESH="${MESOS_DNS_REFRESH}"
fi

# Check for TIMEOUT parameter
if [ -z ${MESOS_DNS_TIMEOUT+x} ]; then
  TIMEOUT="5"
else
  TIMEOUT="${MESOS_DNS_TIMEOUT}"
fi

# Check for vervose logging settings
if [ -z ${VERBOSITY_LEVEL+x} ]; then
  VERBOSITY=""
else
  VERBOSITY="-v=${VERBOSITY_LEVEL}"
fi

# Replace network interface name
sed -i -e "s/%%MESOS_ZK%%/${ZK}/" \
  -e "s/%%IP%%/${LOCAL_IP}/" \
  -e "s/%%HTTP_PORT%%/${PORT}/" \
  -e "s/%%EXTERNAL_DNS_SERVERS%%/${DNS_SERVERS}/" \
  -e "s/%%HTTP_ON%%/${HTTP_ENABLED}/" \
  -e "s/%%IP_SOURCES%%/${IP_SOURCES}/" \
  -e "s/%%REFRESH%%/${REFRESH}/" \
  -e "s/%%TIMEOUT%%/${TIMEOUT}/" \
  $MESOS_DNS_PATH/config.json 

exec $MESOS_DNS_PATH/mesos-dns -config=$MESOS_DNS_PATH/config.json $VERBOSITY
