#!/bin/bash
docker run -d -t -i --restart=always --net=host --name=mesos-dns -p 53:53 hub.dsra.local:5000/dsra/mesos-dns /mesos-dns
