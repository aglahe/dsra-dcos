#!/bin/bash
docker run -name bamboo -t -i --rm -p 8000:8000 -p 80:80  \
     -v /opt/bamboo/bamboo.conf:/config/bamboo.json \
     -v /opt/bamboo/haproxy_template.txt:/config/haproxy_template.txt \
     -e MARATHON_ENDPOINT=http://10.105.0.1:8080 \
     -e BAMBOO_ENDPOINT=http://hub.dsra.local:8000 \
     -e BAMBOO_ZK_HOST=10.105.0.1:2181 \
     -e BAMBOO_ZK_PATH=/bamboo \
     -e BIND=":8000" \
     -e CONFIG_PATH="config/bamboo.json" \
     -e BAMBOO_DOCKER_AUTO_HOST=true \   
     bamboo
