#!/bin/bash
docker stop mesos-dns
docker rm -v mesos-dns

cp dsra-mesos-dns.json /opt/mesos-dns/.

docker run -d -t -i --restart=always --name=mesos-dns --net=host -v /opt/mesos-dns/dsra-mesos-dns.json:/config.json argussecurity/mesos-dns:0.4.0

