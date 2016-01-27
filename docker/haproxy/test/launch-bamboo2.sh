#!/bin/bash

docker stop bamboo

docker rm -v bamboo

docker run -d --name bamboo -t --rm -p 31000:8000 -p 31180:80 \
                               -v /home/core/haproxy_template.cfg:/opt/go/src/github.com/QubitProducts/bamboo/config/haproxy_template.cfg \
                               -e MARATHON_ENDPOINT=http://10.105.0.1,http://10.105.0.3,http://10.105.0.5,http://10.105.0.7,http://10.105.0.9 \
                               -e BAMBOO_ENDPOINT=http://localhost:8000 \
                               -e BAMBOO_ZK_HOST=zk://10.105.0.1:2181,10.105.0.3:2181,10.105.0.5:2181,10.105.0.7:2181,10.105.0.9:2181 \
                               -e BAMBOO_ZK_PATH=/bamboo \
                               -e BIND=":8000" \
                               -e CONFIG_PATH="config/production.example.json" \
                               -e BAMBOO_DOCKER_AUTO_HOST=true \
                               hub.dsra.local:5000/dsra/bamboo:0.2.16.9
