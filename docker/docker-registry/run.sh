#!/bin/bash
docker run -d -t -i --net=host --name docker-registry --restart=always -v /opt/registry/registry_config.yml:/etc/docker/registry/config.yml -v /opt/registry/auth:/auth -v /opt/registry/certs:/certs -v /opt/registry/data:/data -e SETTINGS_FLAVOR=local -e STORAGE_PATH=/data -e LOGLEVEL=DEBUG registry:2.1.1
