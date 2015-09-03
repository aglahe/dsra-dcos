#!/bin/bash
docker run -d -t -i --restart=always --net=host dsra/mesos-dns /mesos-dns
