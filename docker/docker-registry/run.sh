#!/bin/bash
docker run -d -t -i --name registry -p 10.105.255.249:5000:5000 --restart=always -v /opt/registry/data:/data -v /opt/registry/index/docker-registry.db:/tmp/docker-registry.db -v /opt/registry/auth:/auth -v /opt/registry/certs:/certs -v /opt/registry/registry_config.yml:/etc/docker/registry/config.yml registry:2.1.1
