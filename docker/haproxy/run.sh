#!/bin/bash
docker run -d -t -i --restart=always --name=haproxy --net=host -p 80:80 -p 8080:8080 dsra/haproxy  haproxy -f /usr/local/etc/haproxy/haproxy.cfg
