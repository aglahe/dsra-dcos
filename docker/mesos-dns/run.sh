#!/bin/bash
docker run -d -t -i --restart=always --name=mesos-dns -p 53:53 dsra/mesos-dns /mesos-dns
