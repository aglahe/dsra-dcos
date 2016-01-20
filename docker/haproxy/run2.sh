#!/bin/bash
docker run -d --name=haproxy -p 80:80 -v /home/mparker/dsra-dcos/docker/haproxy/dsra.haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro  haproxy:1.5 
