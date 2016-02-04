#!/bin/bash
docker stop mesos-dns
docker rm -v mesos-dns

cp dsra-mesos-dns.json /opt/mesos-dns/.

docker run -d --restart=always --name=mesos-dns --net=host \
              -e MESOS_ZK=zk://10.105.0.1:2181,10.105.0.3:2181,10.105.0.5:2181,10.105.0.7:2181,10.105.0.9:2181/mesos \
              -e LOCAL_IP=10.105.255.249 \
              -e MESOS_DNS_HTTP_ENABLED=true \
              -e VERBOSITY_LEVEL=1 \
              -e MESOS_DNS_PORT=8053 \
              -t hub.dsra.local:5000/aglahe/docker-mesos-dns:0.5.1.4

