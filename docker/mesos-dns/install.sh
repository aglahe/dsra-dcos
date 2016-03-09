#!/usr/bin/env sh

set -ex

apk upgrade
apk update
apk add wget gzip sed bash

# Install Mesos DNS
wget https://github.com/mesosphere/mesos-dns/releases/download/$MESOS_DNS_VERSION/$MESOS_DNS_FILENAME && \
    mkdir -p $MESOS_DNS_PATH && \
    mv $MESOS_DNS_FILENAME $MESOS_DNS_PATH/mesos-dns && \
    chmod +x $MESOS_DNS_PATH/mesos-dns
	
apk del wget gzip
